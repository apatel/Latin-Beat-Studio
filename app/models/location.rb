class Location < ApplicationRecord
  default_scope { order(id: :asc) }
  validates :name, presence: true

  # has_many :events, class_name: FullcalendarEngine::Engine::Event
end
