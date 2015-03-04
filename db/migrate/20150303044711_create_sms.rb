class CreateSMS < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.string :sender
      t.string :receiver
      t.string :body
      t.string :message_sid
      t.references :mobile_phone, index: true
      t.timestamps null: false
    end
  end
end
