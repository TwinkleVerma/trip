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

end
