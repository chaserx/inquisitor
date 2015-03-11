class Question < ActiveRecord::Base
  belongs_to :user
  validates :body, presence: true, length: { in: 1..255 }
  validates :user, presence: true
end
