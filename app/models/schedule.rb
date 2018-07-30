class Schedule < ApplicationRecord
  belongs_to :flight
  has_many :bookings
end
