class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_one :mobile_phone

  store_accessor :settings, :time_zone

  validates :password, length: { minimum: 3 }, if: :crypted_password_changed?
  validates :password, confirmation: true, if: :crypted_password_changed?
  validates :password_confirmation, presence: true, if: :crypted_password_changed?
  validates :email, uniqueness: true, format: { with: /.+@.+\..+/i }, if: :email_changed?
  validates_inclusion_of :time_zone,
                         in: ActiveSupport::TimeZone.zones_map(&:name).keys,
                         message: 'is not a valid Time Zone'
end
