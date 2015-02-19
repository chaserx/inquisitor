class MobilePhone < ActiveRecord::Base
  belongs_to :user
  # TODO(chase): add uniqueness to validation: {scope: :user_id}
  validates :number, presence: true,
                     format: {with: /\A\+\d{11}\z/,
                              message: 'is invalid, please format like ' +
                                       '+18598675309'},
                     uniqueness: {scope: :user_id}

  before_create :set_random_auth_code
  after_update :reset_verification!, if: :verified_and_changed?
  after_save :send_auth_code, if: :unverified_and_new_auth_code?
  before_save :set_random_auth_code, if: :number_changed?

  def verified_and_changed?
    number_changed? && verified?
  end

  def reset_verification!
    update_attribute(:verified, false)
  end

  def self.generate_auth_code
    '%05d' % SecureRandom.random_number(99999)
  end

  def verified!
    update_attribute(:verified, true)
  end

  def unverified?
    !verified?
  end

  private

  def set_random_auth_code
    self.auth_code = self.class.generate_auth_code
  end

  def send_auth_code
    body = "Inquisitor auth code: #{auth_code}"
    SMSWorker.perform_async(number, body)
  end

  def unverified_and_new_auth_code?
    unverified? && auth_code_changed?
  end
end
