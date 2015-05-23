class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers, id: :uuid do |t|
      t.text :body, null: false
      t.uuid :user_id, index: true
      t.uuid :question_id, index: true
      t.timestamps null: false
    end
  end
end
