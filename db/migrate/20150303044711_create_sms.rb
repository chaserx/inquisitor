class CreateSMS < ActiveRecord::Migration
  def change
    create_table :sms, id: :uuid do |t|
      t.string :sender
      t.string :receiver
      t.string :body
      t.string :message_sid
      t.uuid :mobile_phone_id, index: true
      t.timestamps null: false
    end
  end
end
