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
      sms_response = decipher_command @mobile_phone, params['Body']
      render xml: sms_response
    else
      # TODO(chase): wonder what happens on the twilio end of the post?
      head :unprocessable_entity
    end
  end

  private

  def decipher_command mobile_phone, message
    case message.downcase
    when 'start'
      mobile_phone.enable!
      return formulate_response 'OK. Your mobile phone has been enabled.'
    when 'stop'
      mobile_phone.disable!
      formulate_response 'OK. Your mobile phone has been disabled.'
    when 'help'
      help_message = 'Send START to resume questioning. ' +
                     'Send STOP to stop questioning. ' +
                     "Visit #{help_url} to learn more. Messaging & Data rates may apply."
      formulate_response help_message
    else
      # I don't know how to do that
      formulate_response "Unrecognized command. Send help for help or visit #{help_url}"
    end
  end

  def formulate_response message
    twiml = Twilio::TwiML::Response.new do |response|
      response.Message message
    end
    twiml.text
  end
end
