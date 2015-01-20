class SMSWorker
  include Sidekiq::Worker

  def perform number, body
    Twilio::SMSClient.new.send_sms(number, body)
  end
end
