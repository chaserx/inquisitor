class CreateSMS < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.references :mobile_phone, index: true
      t.timestamps null: false
    end
  end
end
