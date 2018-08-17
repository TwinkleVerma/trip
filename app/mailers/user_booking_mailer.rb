class UserBookingMailer < ApplicationMailer

  include BookingsHelper
  include ItinerariesHelper

  def booking_notification_email(data)
    @booking_detail = data
    @source = @booking_detail.get_flight.source.capitalize
    @destinition = @booking_detail.get_flight.destinition.capitalize
    @user_name = get_user_detail(@booking_detail).name
    if @booking_detail.status == 'canceled'
      mail(to: get_user_detail(@booking_detail).email, subject: "Booking canceled")
    else
      mail(to: get_user_detail(@booking_detail).email, subject: "Booking confirmed from #{@source}  to #{@destinition}")
    end
  end
end
