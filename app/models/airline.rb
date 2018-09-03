class Airline < ActiveRecord::Base
  has_many :flights, dependent: :destroy
  has_one :image,as: :imageable, dependent: :destroy
  validates_associated :flights
  validates_associated :image
  validates :name, presence: true
  accepts_nested_attributes_for :image
end
