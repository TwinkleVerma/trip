class Booking < ApplicationRecord
  belongs_to :schedule
  belongs_to :user
  validates :date, presence: true
  validates :status, presence: true
  validates :cost, presence: true, numericality: { only_integer: true }
  validates :schedule_id, presence: true
  validates :user_id, presence: true
end
