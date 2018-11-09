class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def voice
    user = User.find(params[:user])
    @response = Twilio::TwiML::VoiceResponse.new
    gather = Twilio::TwiML::Gather.new(num_digits: '1', action: '/twilio/avialable?user='+params[:user].to_s)
    gather.say(message: 'Hi '+user.name+', this call is for your avialablity confirmation.If you are avialible, press 2. If not avialable, press 3')
    @response.append(gather)
    render xml: @response.to_s
  end

  def avialable
    @response = Twilio::TwiML::VoiceResponse.new
    user_selection = params[:Digits]
    user = User.find(params[:user])
    case user_selection
    when "2"
      twilio = @response.say(message: 'Thank you, for your avialablility')
      user.update({avialable: 1})
      render xml: twilio.to_s
    when "3"
      twilio = @response.say(message: 'We will back to after 5 days, Thank you.')
      user.update({avialable: 0})
      render xml: twilio.to_s
    else
      redirect_to twilio_voice_path
    end
  end

end
