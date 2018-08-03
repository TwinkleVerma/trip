class Flight < ApplicationRecord
  has_one :schedule, dependent: :destroy
  validates_associated :schedule
  belongs_to :airline
  validates :number, presence: true, uniqueness: true
  validates :source, presence: true
  validates :destinition, presence: true
  validates :airline_id, presence: true
end
