class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_user
  @@twilio = TwilioService.new('1', '/twilio/avialable?user='+params[:user].to_s)

  def voice
    response = @@twilio.voice_response
    gather = @@twilio.gather
    gather.say(message: 'Hi '+@user.name+', this call is for your avialablity confirmation.If you are avialible, press 2. If not avialable, press 3')
    response.append(gather)
    render xml: response.to_s
  end

  def avialable
    response = @@twilio.voice_response
    user_selection = params[:Digits]
    case user_selection
    when "2"
      twilio = response.say(message: 'Thank you, for your avialablility')
      @user.update({avialable: 1})
      render xml: twilio.to_s
    when "3"
      twilio = response.say(message: 'We will back to after 5 days, Thank you.')
      @user.update({avialable: 0})
      render xml: twilio.to_s
    else
      redirect_to twilio_voice_path
    end
  end

  protected
  def find_user
    @user = User.find(params[:user])
  end
end
