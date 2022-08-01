class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validate :validate_time_interval

  def validate_time_interval
    unless appointment_time.strftime('%M') == "15"
      errors.add(:appointment_time, "New appointments can only start at 15 mintue intervals")
    end
  end

end
