class Content < ApplicationRecord
  default_scope { order(section: :asc) }

  has_attached_file :content_image, :styles => { :medium => "350x225#", :thumb => "200x75#" }
  validates_attachment :content_image, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }
  attr_accessor :delete_content_image
  before_validation { self.content_image.clear if self.delete_content_image == '1' }

  PAGES = %w(home instructor studio schedule).freeze
  SECTIONS = %w(1 2 3 4 5 image box announcement).freeze

  def page_enum
    Content::PAGES
  end

  def section_enum
    Content::SECTIONS
  end
end
