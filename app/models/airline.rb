class Airline < ApplicationRecord
  has_many :flights
  has_many :pictures, as: :profile
end
