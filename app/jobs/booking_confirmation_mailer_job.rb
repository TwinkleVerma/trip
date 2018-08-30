class BookingConfirmationMailerJob < ApplicationJob
  queue_as :default

  def perform(user)
    UserBookingMailer.booking_notification_email(user).deliver_now
  end

end
