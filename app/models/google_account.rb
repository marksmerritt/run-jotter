# frozen_string_literal: true

class GoogleAccount < ApplicationRecord
  enum status: { pending_verification: 0, connected: 1, disconnected: 2 }

  belongs_to :user

  validates :google_account_id, presence: true
  validates :email, presence: true

  def determine_status
    if disconnected?
      :disconnected
    elsif user.persisted? && (new_record? || pending_verification?)
      :pending_verification
    else
      :connected
    end
  end
end
