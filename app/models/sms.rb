class SMS < ActiveRecord::Base
  belongs_to :mobile_phone
  validates :mobile_phone, presence: true

  def decipher_command message
    help_url = URI.join(ENV['ROOT_URL'], 'help')

    # probably should return hard if message.empty?
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
      # Could be an answer to a sent question.
      # Check if number has a question waiting on an answer. If so, record that.
      # I don't know how to do that. Maybe be more smart in the response
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
