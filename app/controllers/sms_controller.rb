class SMSController < ApplicationController
  skip_before_action :require_login
  skip_before_action :verify_authenticity_token

  def receive
    # TODO(chase): map post to a new SMS object
    #
    # example post params from twilio
    #
    # "ToCountry"=>"US", "ToState"=>"KY",
    # "SmsMessageSid"=>"SMcc7fa7252bcb4b7ae4d5be3feb2af8f0",
    # "NumMedia"=>"0", "ToCity"=>"LEXINGTON", "FromZip"=>"40505",
    # "SmsSid"=>"SMcc7fa7252bcb4b7ae4d5be3feb2af8f0", "FromState"=>"KY",
    # "SmsStatus"=>"received", "FromCity"=>"LEXINGTON", "Body"=>"start",
    # "FromCountry"=>"US", "To"=>"+1859xxxyyyy", "ToZip"=>"40507",
    # "MessageSid"=>"SMcc7fa7252bcb4b7ae4d5be3feb2af8f0",
    # "AccountSid"=>"ACb722d332c59e4d4b9184da537aablarg",
    # "From"=>"+1859aaabbbb", "ApiVersion"=>"2010-04-01"
    #
    @mobile_phone = MobilePhone.where(number: params['From']).first
    if @mobile_phone
      @sms = SMS.new(sms_params.merge(mobile_phone_id: @mobile_phone.id))
      if @sms.save
        # then do something, like send a response if appropriate
        sms_response = @sms.decipher_command params['Body']
      else
        # raise
      end
      
      render xml: sms_response
    else
      # TODO(chase): wonder what happens on the twilio end of the post?
      head :unprocessable_entity
    end
  end

  private

  def sms_params
    { sender: params['From'], receiver: params['To'], body: params['Body'],
     message_sid: params['MessageSid'] }
  end
end
