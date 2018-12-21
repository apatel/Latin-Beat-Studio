require_dependency 'fullcalendar_engine/application_controller'

module FullcalendarEngine
  class EventsController < ApplicationController

    layout FullcalendarEngine::Configuration['layout'] || 'application'

    before_filter :load_event, only: [:edit, :update, :destroy, :move, :resize]
    before_filter :determine_event_type, only: :create

    def index
      cts = ClassType.all
      @color_hash = {}
      cts.each do |ct|
        unless ct.color.blank?
          @color_hash[ct.id] = ct.color
        else
          @color_hash[ct.id] = "792c88"
        end
      end

      respond_to do |format|
        format.html
        format.css
      end
    end

    def create
      classtype = ClassType.find(@event.class_type_id)
      @event.title = classtype.name
      @event.description = classtype.description
      if @event.save
        redirect_back(fallback_location: root_path)
      else
        render text: @event.errors.full_messages.to_sentence, status: 422
      end
    end

    def new
      respond_to do |format|
        format.js
      end
    end

    def get_events
      start_time = Time.at(params[:start].to_i).to_formatted_s(:db)
      end_time   = Time.at(params[:end].to_i).to_formatted_s(:db)

      @events = Event.where('
                  (starttime >= :start_time and endtime <= :end_time) or
                  (starttime >= :start_time and endtime > :end_time and starttime <= :end_time) or
                  (starttime <= :start_time and endtime >= :start_time and endtime <= :end_time) or
                  (starttime <= :start_time and endtime > :end_time)',
                  start_time: start_time, end_time: end_time)
      events = []
      @events.each do |event|
        valid_package = true
        past_class = false
        can_register = true
        if !session[:member_selected].blank?
          member = User.find(session[:member_selected])
          current_packages = member.find_valid_packages(ClassType.find(event.class_type_id), event.starttime)
          if current_packages.blank?
            valid_package = false
          end
          can_register = ClassRegistration.where(user: member, fullcalendar_engine_events_id: event.id).blank?
        else
          unless current_user.nil? || current_user.admin
            current_packages = current_user.find_valid_packages(ClassType.find(event.class_type_id), event.starttime)
            if current_packages.blank?
              valid_package = false
            end
            can_register = ClassRegistration.where(user: current_user, fullcalendar_engine_events_id: event.id).blank?
          end
        end
        if event.starttime < DateTime.now.in_time_zone("America/New_York") && !current_user.nil? && !current_user.admin
          past_class = true
        end
        i = Instructor.where(id: event.instructor_id).first
        if i.blank?
          instructor = "TBD"
        else
          instructor = i.name
        end
        events << { id: event.id,
                    title: event.title,
                    description: event.description || '',
                    instructor: instructor,
                    location_id: event.location_id,
                    class_type_id: event.class_type_id,
                    valid_package: valid_package,
                    can_register: can_register,
                    past_class: past_class,
                    start: event.starttime.iso8601,
                    end: event.endtime.iso8601,
                    allDay: event.all_day,
                    recurring: (event.event_series_id) ? true : false,
                    fulldate: event.starttime.to_datetime.strftime('%A %D - %I:%M %p'),
                    starttime: event.starttime.to_datetime.strftime('%D %I:%M %p')}
      end
      render json: events.to_json
    end

    def move
      if @event
        @event.starttime = make_time_from_minute_and_day_delta(@event.starttime)
        @event.endtime   = make_time_from_minute_and_day_delta(@event.endtime)
        @event.all_day   = params[:all_day]
        @event.save
      end
      render nothing: true
    end

    def resize
      if @event
        @event.endtime = make_time_from_minute_and_day_delta(@event.endtime)
        @event.save
      end
      render nothing: true
    end

    def edit
      render json: { form: render_to_string(partial: 'edit_form') }
    end

    def update
      classtype = ClassType.find(params[:event][:class_type_id])
      @event.title = classtype.name
      @event.description = classtype.description
      case params[:event][:commit_button]
      when 'All Occurrences'
        @events = @event.event_series.events
        @event.update_events(@events, event_params)
      when 'All Following Occurrences'
        @events = @event.event_series.events.where('starttime > :start_time',
                                                   start_time: @event.starttime.to_formatted_s(:db)).to_a
        @event.update_events(@events, event_params)
      end
      @event.attributes = event_params
      @event.save!
      redirect_back(fallback_location: root_path)
    end

    def destroy
      case params[:delete_all]
      when 'true'
        crs = ClassRegistration.where(fullcalendar_engine_events_id: @event.id)
        crs.each do |cr|
          if cr.purchase.quantity_used < 2
            cr.purchase.reset_expire
          end
          cr.destroy
        end
        @event.event_series.destroy
      when 'future'
        crs = ClassRegistration.where(fullcalendar_engine_events_id: @event.id)
        crs.each do |cr|
          if cr.purchase.quantity_used < 2
            cr.purchase.reset_expire
          end
          cr.destroy
        end
        @events = @event.event_series.events.where('starttime > :start_time',
                                                   start_time: @event.starttime.to_formatted_s(:db)).to_a
        @event.event_series.events.delete(@events)
      else
        crs = ClassRegistration.where(fullcalendar_engine_events_id: @event.id)
        crs.each do |cr|
          if cr.purchase.quantity_used < 2
            cr.purchase.reset_expire
          end
          cr.destroy
        end
        @event.destroy
      end
      render nothing: true
    end

    private

    def load_event
      @event = Event.where(:id => params[:id]).first
      unless @event
        render json: { message: "Event Not Found.."}, status: 404 and return
      end
    end

    def event_params
      params.require(:event).permit('title', 'description', 'instructor_id', 'location_id', 'class_type_id', 'starttime', 'endtime', 'all_day', 'period', 'frequency', 'commit_button')
    end

    def determine_event_type
      if params[:event][:period] == "Does not repeat"
        @event = Event.new(event_params)
      else
        @event = EventSeries.new(event_params)
      end
    end

    def make_time_from_minute_and_day_delta(event_time)
      params[:minute_delta].to_i.minutes.from_now((params[:day_delta].to_i).days.from_now(event_time))
    end
  end
end
