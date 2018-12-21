class ClassType < ApplicationRecord
  default_scope { order(id: :asc) }
  validates :name, presence: true

  has_and_belongs_to_many :passes
  has_and_belongs_to_many :instructors
  has_attached_file :class_image, :styles => { :medium => "350x225#", :thumb => "200x75#" }
  validates_attachment :class_image, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }
  validates :color, :css_hex_color => true
  attr_accessor :delete_class_image
  before_validation { self.class_image.clear if self.delete_class_image == '1' }
end
