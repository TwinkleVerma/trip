class Crew < ApplicationRecord

  belongs_to :user
  belongs_to :flight

  after_save :send_mail
  after_save :sms_notification

  private

  def send_mail
    UserFlightAssignMailer.flight_assignment_notification_mail(self).deliver_later(wait_until: 1.hours.from_now)
  end

  def sms_notification
    @twilio_number = '+15085036936'
    auth_token = 'f70c11f86b24a0986dc5f7db2e449aef'
    account_sid = 'AC26fc510a58e871f155ff5326a1d60602'
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    reminder = "Hi #{self.user.name}. Air Traffic Manager have assigned you #{self.flight.number} flight of #{self.flight.airline.name}.\n Thank You!"
    message = @client.api.account.messages.create(
      :from => @twilio_number,
      :to => '+91'+self.user.contact,
      :body => reminder,
    )
  end
end
