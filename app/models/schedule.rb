class Schedule < ApplicationRecord
  enum scheduleday: { 'monday': 1, 'tuesday': 2, 'wednesday': 3, 'thursday': 4, 'friday': 5, 'saturday': 6, 'sunday': 0 }

  belongs_to :flight
  has_many :bookings, dependent: :destroy
  has_many :disable_schedules, dependent: :destroy
  validates_associated :bookings
  validates :depart_time, presence: true
  validates :arrival_time, presence: true
  validates :flight_id, presence: true
  validates :base_cost, presence: true, numericality: { only_integer: true }

  scope :include_model, ->(model_name) {includes(model_name)}

end
