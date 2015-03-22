class Question < ActiveRecord::Base
  belongs_to :user
  validates :body, presence: true, length: { in: 1..255 }
  validates :user_id, presence: true

  STOCK_QUESTIONS = ['Are you working?', 'Who are you with?', 'How do you feel?'].freeze
end
