class LogsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_user, only: [:callback, :call]

  def call
    twilio_number = Rails.application.config.twilio_configuration[:twilio_number]
    auth_token = Rails.application.config.twilio_configuration[:auth_token]
    account_sid = Rails.application.config.twilio_configuration[:account_sid]
    link = 'https://995a79cf.ngrok.io/users/'+@user.id.to_s+'/callback'
    client = TwilioService.new.client(account_sid, auth_token)
    begin
      call = client.calls.create(
            method: 'GET',
            status_callback: link,
            status_callback_method: 'POST',
            url: 'https://995a79cf.ngrok.io/twilio/voice.xml?user='+@user.id.to_s,
            to: '+91'+@user.contact,
            from: twilio_number
          )
    redirect_to users_path
    rescue TwilioService.new.error => e
      flash[:danger] = e.message
    end
  end

  def callback
    @user.logs.create({callfrom: params[:Caller], duration: params[:CallDuration], status: params[:CallStatus], accountSid: params[:AccountSid], callSid: params[:CallSid]})
  end

  protected
  def find_user
    @user = User.find(params[:user_id])
  end
end
