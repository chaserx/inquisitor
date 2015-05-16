class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_one :mobile_phone
  has_many :questions
  has_many :answers

  store_accessor :settings, :time_zone

  validates :password, length: { minimum: 3 }, if: :crypted_password_changed?
  validates :password, confirmation: true, if: :crypted_password_changed?
  validates :password_confirmation, presence: true, if: :crypted_password_changed?
  validates :email, presence: true
  validates :email, uniqueness: true, format: { with: /.+@.+\..+/i }, if: :email_changed?
  validates_inclusion_of :time_zone,
                         in: ActiveSupport::TimeZone.zones_map(&:name).keys,
                         message: 'is not a valid Time Zone'

  before_save :set_gravatar_url
  after_create :add_stock_questions

  def short_name
    email[/[^@]+/]
  end

  private

  def set_gravatar_url
    gravatar_hash = Digest::MD5.hexdigest(email)
    self.gravatar_url = "//www.gravatar.com/avatar/#{gravatar_hash}/d=retro"
  end

  def add_stock_questions
    Question::STOCK_QUESTIONS.each do |q|
      self.questions.create(body: q)
    end
  end
end
