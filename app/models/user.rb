# frozen_string_literal: true

class User < ApplicationRecord
  PASSWORD_RESET_TOKEN_EXPIRY = 30.minutes.freeze
  EMAIL_VERIFICATION_TOKEN_EXPIRY = 48.hours.freeze

  has_secure_password
  attribute :generate_random_password, :boolean, default: false

  has_many :sign_ins, dependent: :destroy
  has_many :google_accounts, dependent: :destroy
  has_many :activities

  generates_token_for :email_verification, expires_in: EMAIL_VERIFICATION_TOKEN_EXPIRY do
    email
  end
  generates_token_for :password_reset, expires_in: PASSWORD_RESET_TOKEN_EXPIRY do
    password_salt&.last(10)
  end

  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, password_strength: true, length: { minimum: 8 }, if: :validate_password?
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..21 }
  validate :time_zone_supported

  normalizes :email, with: ->(email) { email.strip.downcase }
  normalizes :username, with: ->(username) { username.squish.parameterize.underscore }

  after_initialize :set_random_username, if: -> { new_record? }
  before_validation :set_random_password, if: -> { new_record? && generate_random_password? }
  after_create_commit :send_email_verification_mailer

  def skip_email_verification!
    self.email_verified_at = Date.current
  end

  def email_verified!
    update(email_verified_at: Date.current)
  end

  def email_verified?
    email_verified_at.present?
  end

  def email_verification_past_due?
    created_at < EMAIL_CONFIRMATION_TOKEN_EXPIRY.ago
  end

  def send_email_verification_mailer
    Identity::EmailMailer.with(
      user: self,
      token: self.generate_token_for(:email_verification)
    ).email_verification.deliver_later
  end

  def send_password_reset_mailer
    Identity::PasswordMailer.with(
      user: self,
      token: self.generate_token_for(:password_reset)
    ).password_reset.deliver_later
  end

  private

  def set_random_password
    self.password ||= SecureRandom.hex + "1Rj!"
  end

  def set_random_username
    return if username.present?

    loop do
      self.username = UsernameGenerator.generate
      break if User.find_by(username: username).nil?
    end
  end

  def time_zone_supported
    return unless time_zone.present?
    return if ActiveSupport::TimeZone[time_zone].present?

    errors.add(:time_zone, "is not supported")
  end

  def validate_password?
    new_record? || password.present?
  end
end
