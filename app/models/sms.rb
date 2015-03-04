class SMS < ActiveRecord::Base
  belongs_to :mobile_phone
  validates :mobile_phone, presence: true
end
