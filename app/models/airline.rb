class Airline < ApplicationRecord
  has_many :flights, dependent: :destroy
  has_one :image,as: :imageable, dependent: :destroy
  validates_associated :flights
  validates :name, presence: true
end
