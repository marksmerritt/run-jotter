# frozen_string_literal: true

class GoogleAccountConnection
  include ActiveModel::Model

  attr_accessor :google_account_attrs, :email, :user, :google_account

  validates_presence_of :google_account_attrs, :email

  def initialize(credential:)
    @payload_from_google = Google::Auth::IDTokens.verify_oidc(credential, aud: Rails.application.credentials.google_oauth.client_id)
    @google_account_attrs = parse_payload(@payload_from_google)
    @email = @google_account_attrs[:email]
    @user = set_user
    @google_account = set_google_account
  end

  def perform
    set_user_attrs_from_google_account

    return false unless user.valid?

    user.save!
  end

  def parse_payload(payload)
    {
      google_account_id: payload["sub"],
      email: payload["email"],
      email_verified: payload["email_verified"],
      picture_url: payload["picture_url"],
      first_name: payload["given_name"],
      last_name: payload["family_name"],
      locale: payload["locale"]
    }
  end

  def set_user
    user = User.find_or_initialize_by(email: email)
    user.generate_random_password = true if user.new_record?

    user
  end

  def set_google_account
    google_account = user.google_accounts.find_or_initialize_by(email: email)
    status = google_account.determine_status
    google_account.assign_attributes(google_account_attrs.merge(status: status))

    google_account
  end

  def set_user_attrs_from_google_account
    user.first_name ||= google_account_attrs[:first_name]
    user.last_name ||= google_account_attrs[:last_name]
    user.skip_email_verification! if google_account.email_verified?
  end
end
