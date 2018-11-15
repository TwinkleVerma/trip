class TwilioService
  def voice_response
    Twilio::TwiML::VoiceResponse.new
  end

  def gather(digit, action)
    Twilio::TwiML::Gather.new(num_digits: digit, action: action)
  end

  def client(account_sid, auth_token)
    Twilio::REST::Client.new(account_sid, auth_token)
  end

  def error
    Twilio::REST::TwilioError
  end
end
