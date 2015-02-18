class SMSWorker
  include Sidekiq::Worker
  sidekiq_options queue: :sms

  def perform number, body
    Twilio::SMSClient.new.send_sms(number, body)
  end
end
