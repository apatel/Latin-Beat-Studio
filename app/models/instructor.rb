class Instructor < ApplicationRecord
  default_scope { order(name: :asc) }

  has_and_belongs_to_many :class_types
  belongs_to :user, optional: true
  # has_many :events, class_name: FullcalendarEngine::Engine::Event

  has_attached_file :instructor_image, :styles => { :medium => "350x350#", :thumb => "200x200#" }
  validates_attachment :instructor_image, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }
  attr_accessor :delete_instructor_image#, :name, :title, :playlist, :fb_handle, :fb_link, :ig_handle, :ig_link, :bio

  before_validation { self.instructor_image.clear if self.delete_instructor_image == '1' }

  def get_classes
    return FullcalendarEngine::Event.where("instructor_id = ? AND starttime >= ? AND starttime <= ?", self.id, DateTime.now.in_time_zone("America/New_York"), DateTime.now.in_time_zone("America/New_York") + 14.days)
  end
end
