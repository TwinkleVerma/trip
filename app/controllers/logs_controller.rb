class LogsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_user, only: [:callback, :call]
  @@twilio = TwilioService.new
  def call
    link = 'https://ee4546d2.ngrok.io/users/'+@user.id.to_s+'/callback'
    client = @@twilio.client
    begin
      call = client.calls.create(
            method: 'GET',
            status_callback: link,
            status_callback_method: 'POST',
            url: 'https://ee4546d2.ngrok.io/twilio/voice.xml?user='+@user.id.to_s,
            to: '+91'+@user.contact,
            from: @@twilio.twilio_number
          )
    redirect_to users_path
    rescue @@twilio.error => e
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
