class ClassRegistration < ApplicationRecord

  default_scope { order(id: :asc) }

  belongs_to :user
  belongs_to :class_type
  belongs_to :purchase

  def get_instructor
    event = FullcalendarEngine::Event.where(id: self.fullcalendar_engine_events_id).first
    if event.blank?
      return "Class Removed"
    else
      i = Instructor.where(id: event.instructor_id).first
      if i.blank?
        return "TBD"
      else
        return i.name
      end
    end
  end

  def get_class_type
    event = FullcalendarEngine::Event.where(id: self.fullcalendar_engine_events_id).first
    if event.blank?
      return "Class Removed"
    else
      return ClassType.find(event.class_type_id).name
    end
  end

  def get_class_date_time
    event = FullcalendarEngine::Event.where(id: self.fullcalendar_engine_events_id).first
    if event.blank?
      return "Class Removed"
    else
      return "#{event.starttime.to_datetime.strftime('%A %D')} - #{event.starttime.to_datetime.strftime('%I:%M %p')}"
    end
  end

  def can_cancel?
    event = FullcalendarEngine::Event.where(id: self.fullcalendar_engine_events_id).first
    if event.blank?
      return false
    else
      start_time = event.starttime
      cancel_time = start_time - 2.hours
      return Time.zone.now < cancel_time
    end
  end

end
