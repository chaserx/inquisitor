class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :body, null: false
      t.boolean :private, default: false
      t.boolean :askable, default: true
      t.boolean :awaiting_answer, default: false
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
