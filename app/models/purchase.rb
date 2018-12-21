class Purchase < ApplicationRecord
  default_scope { order(created_at: :asc) }
  belongs_to :user
  belongs_to :pass
  has_many :class_registrations, dependent: :destroy

  def get_purchase_date
    return "#{self.created_at.to_datetime.strftime('%D')}"
  end

  def get_expire_date
    unless self.expire.blank?
      return "#{self.expire.to_datetime.strftime('%D')}"
    else
      return nil
    end
  end

  def valid_date?
    if self.expire.blank? || self.expire.to_date >= DateTime.now.in_time_zone("America/New_York").to_date
      return true
    end
    return false
  end

  def valid_date_for_reg?(class_date)
    if self.expire.blank? || (self.expire.to_date >= DateTime.now.in_time_zone("America/New_York").to_date && self.expire.to_date >= class_date.to_date)
      return true
    end
    return false
  end

  def valid_quantity?
    if self.class_registrations.count < self.pass.quantity
      return true
    end
    return false
  end

  def valid_class_type?(class_type)
    if self.pass.class_types.include?(class_type)
      return true
    end
    return false
  end

  def quantity_available
    return self.pass.quantity - self.class_registrations.count
  end

  def quantity_available_display
    if self.pass.quantity > 400 #FIXME make this number a constant
      return "Unlimited"
    else
      return self.quantity_available
    end
  end

  def quantity_used
    return self.class_registrations.count
  end

  def set_expire
    expire = self.pass.expiration_days
    self.update(expire: Date.today + expire.days)
    registrations = self.class_registrations
    registrations.each do |r|
      if r.class_date > self.expire.to_date
        r.delete
      end
    end
  end

  def reset_expire
    self.update(expire: nil)
  end

  def can_remove?
    self.expire.blank? && self.quantity_used == 0
  end
end
