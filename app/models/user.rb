class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable,
         :authentication_keys => [:login]

  validates :username,
            :presence => true,
            :uniqueness => {
              :case_sensitive => false
            }

  validates :email,
            :presence => true,
            :uniqueness => {
              :case_sensitive => false
            }

  validates :waiver,
            :presence => true

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  has_many :class_registrations, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :instructors, dependent: :destroy

  attr_accessor :login

  def name
    "#{self.username}"
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def current_purchases
    current = []
    self.purchases.each do |o|
      if o.valid_date? #&& o.valid_quantity?
        current << o
      end
    end
    return current.sort_by{|k| k["created_at"] }
  end

  def past_purchases
    past = []
    self.purchases.each do |o|
      if !o.valid_date? #&& o.valid_quantity?
        past << o
      end
    end
    return past.sort_by{|k| k["created_at"] }
  end

  def find_valid_packages(class_type, class_date)
    current = []
    self.purchases.each do |o|
      if o.valid_quantity? && o.valid_class_type?(class_type) && o.valid_date_for_reg?(class_date) && !o.suspend
        current << o
      end
    end
    return current.sort_by{|k| k["created_at"] }
  end

  def fullname
    unless self.first_name.blank? || self.last_name.blank?
      return "#{self.first_name} #{self.last_name}"
    else
      return self.name
    end
  end

  def autocomplete_name
    unless self.first_name.blank? || self.last_name.blank?
      return "#{self.first_name} #{self.last_name} (#{self.username})"
    else
      return "(#{self.username})"
    end
  end

  def previous_purchase?(pass)
    self.purchases.each do |purchase|
      if purchase.pass == pass
        return true
      end
    end
    return false
  end

end
