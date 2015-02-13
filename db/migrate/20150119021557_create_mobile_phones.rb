class CreateMobilePhones < ActiveRecord::Migration
  def change
    create_table :mobile_phones do |t|
      t.string   :number
      t.string   :auth_code
      t.boolean  :verified
      t.boolean  :disabled
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
