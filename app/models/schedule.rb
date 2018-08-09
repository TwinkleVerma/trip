class Schedule < ApplicationRecord
  belongs_to :flight
  has_many :bookings, dependent: :destroy
  validates_associated :bookings
  validates :depart_time, presence: true
  validates :arrival_time, presence: true
  validates :flight_id, presence: true
  validates :base_cost, presence: true, numericality: { only_integer: true }
end
