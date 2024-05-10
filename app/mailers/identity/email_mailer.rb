# frozen_string_literal: true

class Identity::EmailMailer < ApplicationMailer
  def email_verification
    mail to: params[:user].email
  end
end
