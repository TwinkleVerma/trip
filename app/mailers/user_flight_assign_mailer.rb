class UserFlightAssignMailer < ApplicationMailer
  def flight_assignment_notification_mail(data)
    @user = data.user
    @flight = data.flight
    mail(to: data.user.email, subject: 'Flight Assigned')
  end
end
