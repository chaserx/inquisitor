class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body, null: false
      t.references :question, index: true
      t.timestamps null: false
    end
  end
end
