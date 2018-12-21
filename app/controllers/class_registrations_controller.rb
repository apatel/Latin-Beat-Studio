class ClassRegistrationsController < ApplicationController

  before_action :check_waiver_date

  def check_waiver_date
    unless current_user.nil? || current_user.admin
      if current_user.waiver_date.nil? || current_user.waiver_date < Date.today - 1.year
        redirect_to edit_user_registration_path(waiver: false)
      end
    end
  end

  def register
    event_id = params[:event_id]
    @event = FullcalendarEngine::Event.find(event_id)
    @date = @event.starttime.to_datetime.strftime('%A %D')
    @stime = @event.starttime.to_datetime.strftime('%I:%M %p')
    @etime = @event.endtime.to_datetime.strftime('%I:%M %p')

    if !current_user.nil? && current_user.admin && !session[:member_selected].blank?
      @user = User.find(session[:member_selected])
    elsif !current_user.nil? && !current_user.admin
      @user = current_user
    end

    unless @user.nil?
      @class_type = ClassType.find(@event.class_type_id)

      if ClassRegistration.where(user: @user, fullcalendar_engine_events_id: @event.id).blank?
        if params[:purchase_id]
          #user has selected the purchase to use
          cr = ClassRegistration.create(fullcalendar_engine_events_id: @event.id, class_type: @class_type, user: @user, class_date: @event.starttime, purchase: Purchase.find(params[:purchase_id]))
          p "Registered. A package was selected."
          redirect_to fullcalendar_path, :flash => {success: 'You have successfully registered for the class.'}
        else
          @current_packages = @user.find_valid_packages(@class_type, @event.starttime)
          if @current_packages.blank?
            p "No valid package."
            redirect_to fullcalendar_path, :flash => {danger: 'You do not have a valid package.'}
          elsif @current_packages.length == 1
            cr = ClassRegistration.create(fullcalendar_engine_events_id: @event.id, class_type: @class_type, user: @user, class_date: @event.starttime, purchase: @current_packages[0])
            p "Registered. Only one package available."
            redirect_to fullcalendar_path, :flash => {success: 'You have successfully registered for the class.'}
          elsif @current_packages.length > 1
            p "Choose package"
            #user needs to choose purchase
          end
        end
      else
        p "You are already registered for this class."
        redirect_to fullcalendar_path, :flash => {danger: 'You are already registered for this class.'}
      end
    end
  end

  def roster
    event_id = params[:event_id]
    @event = FullcalendarEngine::Event.find(event_id)
    @date = @event.starttime.to_datetime.strftime('%A %D')
    @class_registrations = ClassRegistration.where(fullcalendar_engine_events_id: @event.id)
    @reg_count = @class_registrations.length

    @mailto = "mailto:info@latinbeatstudio.com?bcc="
    @class_registrations.each do |cr|
      @mailto = @mailto + cr.user.email + ";"
    end
  end

  def cancel
    if params[:roster]
      @cr = ClassRegistration.find(params[:reg])
      @event = FullcalendarEngine::Event.find(@cr.fullcalendar_engine_events_id)
      if @cr.purchase.quantity_used < 2
        @cr.purchase.reset_expire
      end
      @cr.destroy
      @class_registrations = ClassRegistration.where(fullcalendar_engine_events_id: @event.id)
      respond_to do |format|
        format.js { }
      end
    else
      @cr = ClassRegistration.find(params[:reg])
      @cr.destroy
      redirect_to accounts_url, :flash => {success: 'You have successfully canceled your registration.'}
    end
  end

  def attended
    #if manually clicked from roster
    if params[:reg]
      reg = ClassRegistration.find(params[:reg])
      reg.update(attended: true)
      reg.update(no_show: false)
      if reg.purchase.expire.blank?
        Purchase.find(reg.purchase).set_expire
      end
      @event = FullcalendarEngine::Event.find(reg.fullcalendar_engine_events_id)
      @class_registrations = ClassRegistration.where(fullcalendar_engine_events_id: @event.id)
      respond_to do |format|
        format.js { }
      end
    end
  end

  def no_show
    #if manually clicked from roster
    if params[:reg]
      reg = ClassRegistration.find(params[:reg])
      reg.update(no_show: true)
      reg.update(attended: false)
      if reg.purchase.expire.blank?
        Purchase.find(reg.purchase).set_expire
      end
      @event = FullcalendarEngine::Event.find(reg.fullcalendar_engine_events_id)
      @class_registrations = ClassRegistration.where(fullcalendar_engine_events_id: @event.id)
      respond_to do |format|
        format.js { }
      end
    end
  end

  def paid
    #if manually clicked from roster
    if params[:reg]
      reg = ClassRegistration.find(params[:reg])
      if reg.purchase.paid
        Purchase.find(reg.purchase).update(paid: false)
      else
        Purchase.find(reg.purchase).update(paid: true)
      end
      @event = FullcalendarEngine::Event.find(reg.fullcalendar_engine_events_id)
      @class_registrations = ClassRegistration.where(fullcalendar_engine_events_id: @event.id)
      respond_to do |format|
        format.js { }
      end
    end
  end

  def submit
    #submit all no_shows
    event_id = params[:event_id]
    @event = FullcalendarEngine::Event.find(event_id)
    @class_registrations = ClassRegistration.where(fullcalendar_engine_events_id: event_id)

    @class_registrations.each do |reg|
      if !reg.attended
        reg.update(no_show: true)
        if reg.purchase.expire.blank?
          Purchase.find(reg.purchase).set_expire
        end
      end
    end
    respond_to do |format|
      format.js { }
    end
  end

  def qr_scan
    #if coming from QR code
    if params[:uid]
      @user = User.find(params[:uid])
      @event = FullcalendarEngine::Event.where("starttime > ?", (DateTime.now.in_time_zone("America/New_York").to_time - 30.minutes).to_datetime).order("starttime ASC").first
      reg = ClassRegistration.where(user: @user, fullcalendar_engine_events_id: @event.id).first
      @message = ""
      #if already registered for the class
      if reg
        reg.update(attended: true)
        reg.update(no_show: false)
        if reg.purchase.expire.blank?
          @pur = Purchase.find(reg.purchase)
          @pur.set_expire
        end
        @message = "#{@user.fullname} was marked as attended."

      else
        #if not registered for the class, register then mark as attended
        @class_type = ClassType.find(@event.class_type_id)
        @current_packages = @user.find_valid_packages(@class_type, @event.starttime)
        if @current_packages.blank?
          p "No valid package."
          @message = "#{@user.fullname} does not have a valid package for this class."
          return
        elsif @current_packages.length == 1
          cr = ClassRegistration.create(fullcalendar_engine_events_id: @event.id, class_type: @class_type, user: @user, class_date: @event.starttime, purchase: @current_packages[0])
          cr.update(attended: true)
          cr.update(no_show: false)
          if cr.purchase.expire.blank?
            @pur = Purchase.find(cr.purchase)
            @pur.set_expire
          end
          p "Registered. Only one package available."
          @message = "#{@user.fullname} was registered and marked as attended."
        elsif @current_packages.length > 1
          p "Choose package"
          @message = "Cannot register automatically. #{@user.fullname} has more than one valid package for this class."
        end
      end
    end
  end

end
