class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_one :mobile_phone

  validates :password, length: { minimum: 3 }, if: :crypted_password_changed?
  validates :password, confirmation: true, if: :crypted_password_changed?
  validates :password_confirmation, presence: true, if: :crypted_password_changed?
  validates :email, uniqueness: true, format: { with: /.+@.+\..+/i }, if: :email_changed?
end
