class Booking < ApplicationRecord
  attribute :status, :string, default: "confirmed"

  enum status: {confirmed: "confirmed", canceled: "canceled"}

  belongs_to :schedule
  belongs_to :user

  validates :date, presence: true
  validates :status, presence: true
  validates :cost, presence: true, numericality: {only_integer: true}
  validates :schedule_id, presence: true
  validates :user_id, presence: true


  after_save :send_mail

  def get_flight
    schedule.flight
  end

  private

  def send_mail
    UserBookingMailer.booking_notification_email(self).deliver_now
  end

end
