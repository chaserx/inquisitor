module Twilio
  class SMSClient
    def initialize args={}
      @sid = args['TWILIO_ACCOUNT_SID'] || ENV['TWILIO_ACCOUNT_SID']
      @auth_token = args['TWILIO_AUTH_TOKEN'] || ENV['TWILIO_AUTH_TOKEN']
    end

    def client
      Twilio::REST::Client.new(@sid, @auth_token)
    end

    def send_sms number, body
      client.account.messages.
             create(from: ENV['TWILIO_DEFAULT_FROM'], to: number, body: body)
    end
  end
end
