class Pass < ApplicationRecord
  default_scope { order(id: :asc) }

  has_and_belongs_to_many :class_types
  has_many :purchases

  validates :quantity, :expiration_days, :presence => true

  # CATEGORIES = ["Class Packages", "Small Group Fitness", "A La Carte", "Flexible Packages", "Gift Certificates"].freeze

  def category_enum
    PassType.all.reorder('view_order asc').collect {|x| x.name }
  end

  def self.all_categories
    PassType.all.reorder('view_order asc').collect {|x| x.name }
  end

  def quantity_display
    if self.quantity.nil?
      self.quantity = 500
      return "Unlimited"
    elsif self.quantity > 400 #FIXME make this number a constant
      return "Unlimited"
    else
      return self.quantity
    end
  end
end
