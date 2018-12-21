class StudioEvent < ApplicationRecord
  default_scope { order(start_date: :asc) }
  has_attached_file :event_image, :styles => { :medium => "425x275#", :thumb => "200x200#" }
  validates_attachment :event_image, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }
  attr_accessor :delete_event_image
  before_validation { self.event_image.clear if self.delete_event_image == '1' }
end
