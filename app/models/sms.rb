class SMS < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :mobile_phone
  validates :mobile_phone, presence: true

  def decipher_command message, host
    default_url_options[:host] = host

    # probably should return hard if message.empty?
    case message.downcase
    when 'start'
      mobile_phone.enable!
      return 'OK. Your mobile phone has been enabled.'
    when 'stop'
      mobile_phone.disable!
      return 'OK. Your mobile phone has been disabled.'
    when 'help'
      help_message = 'Send START to resume questioning. ' +
                     'Send STOP to stop questioning. ' +
                     "Visit #{help_url} to learn more. Messaging & Data rates may apply."
      return help_message
    else
      # Could be an answer to a sent question.
      # Check if number has a question waiting on an answer. If so, record that.
      # All elst failes, 'I don't know how to do that.'
      return "Unrecognized command. Send help for help or visit #{help_url}"
    end
  end
end
