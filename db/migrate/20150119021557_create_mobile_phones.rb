class CreateMobilePhones < ActiveRecord::Migration
  def change
    create_table :mobile_phones, id: :uuid do |t|
      t.string   :number
      t.string   :auth_code
      t.boolean  :verified
      t.boolean  :disabled
      t.uuid     :user_id, index: true
      t.timestamps null: false
    end
  end
end
