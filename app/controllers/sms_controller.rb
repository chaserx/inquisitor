class SMSController < ApplicationController
  skip_before_action :require_login
  skip_before_action :verify_authenticity_token

  def receive
    @mobile_phone = MobilePhone.where(number: params['From']).first
    if @mobile_phone
      sms_response = decipher_command @mobile_phone, params['Body']
      render xml: sms_response
    else
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
      help_message = 'Send start to resume questions. ' +
                     'Send stop to take a break from the questions. ' +
                     "Visit #{help_url} to learn more."
      formulate_response help_message
    else
      # I don't know how to do that
      formulate_response 'Unrecognized command. Send help for help or visit SOMEURL/help'
    end
  end

  def formulate_response message
    twiml = Twilio::TwiML::Response.new do |response|
      response.Message message
    end
    twiml.text
  end
end
