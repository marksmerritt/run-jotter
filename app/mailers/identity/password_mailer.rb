# frozen_string_literal: true

class Identity::PasswordMailer < ApplicationMailer
  def password_reset
    mail to: params[:user].email
  end
end
