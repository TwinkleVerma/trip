class Schedule < ApplicationRecord
  belongs_to :flight
  has_many :bookings, dependent: :destroy
end
