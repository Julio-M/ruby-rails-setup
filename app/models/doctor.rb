class Doctor < ApplicationRecord
  has_many :appointments, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
end
