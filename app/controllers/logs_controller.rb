class LogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def call
    user = User.find(params[:user_id])
    @twilio_number = '+15085036936'
    auth_token = 'f70c11f86b24a0986dc5f7db2e449aef'
    account_sid = 'AC26fc510a58e871f155ff5326a1d60602'
    link = 'https://c20b6306.ngrok.io/users/'+user.id.to_s+'/callback'
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    begin
      @call = @client.calls.create(
            method: 'GET',
            status_callback: link,
            status_callback_method: 'POST',
            url: 'https://c20b6306.ngrok.io/twilio/voice.xml?user='+user.id.to_s,
            to: '+91'+user.contact,
            from: @twilio_number
          )
    redirect_to users_path
    rescue Twilio::REST::TwilioError => e
      flash[:danger] = e.message
    end
  end

  def callback
    user = User.find(params[:user_id])
    user.logs.create({callfrom: params[:Caller], duration: params[:CallDuration], status: params[:CallStatus], accountSid: params[:AccountSid], callSid: params[:CallSid]})
  end
end
