class CreateCellPhones < ActiveRecord::Migration
  def change
    create_table :cell_phones do |t|
      t.string   :number
      t.string   :auth_code
      t.boolean  :verified
      t.boolean  :disabled
      t.timestamps null: false
    end
  end
end
