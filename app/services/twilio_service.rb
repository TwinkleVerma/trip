class TwilioService

  attr_reader :twilio_number

  def initialize(*args)
    @twilio_number = Rails.application.config.twilio_configuration[:twilio_number]
    @auth_token = Rails.application.config.twilio_configuration[:auth_token]
    @account_sid = Rails.application.config.twilio_configuration[:account_sid]
    @digit = args[0]
    @action = args[1]
  end
  def voice_response
    Twilio::TwiML::VoiceResponse.new
  end

  def gather
    Twilio::TwiML::Gather.new(num_digits: @digit, action: @action)
  end

  def client
    Twilio::REST::Client.new(@account_sid, @auth_token)
  end

  def error
    Twilio::REST::TwilioError
  end

end
