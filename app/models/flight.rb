class Flight < ApplicationRecord

  has_many :schedules, dependent: :destroy
  has_many :crews, dependent: :destroy
  has_many :users, through: :crews

  belongs_to :airline

  validates_associated :schedules
  validates :number, presence: true, uniqueness: true
  validates :source, presence: true
  validates :destinition, presence: true
  validates :airline_id, presence: true

  scope :flight_id, ->(id) {where('flights.id = '+id.to_s)}

  scope :include_model, ->(model_name) {includes(model_name)}
end
