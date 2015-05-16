class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  default_scope { order(created_at: :desc) }

  validates :body, presence: true
end
