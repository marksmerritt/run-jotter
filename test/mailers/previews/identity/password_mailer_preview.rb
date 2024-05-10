# Preview all emails at http://localhost:3000/rails/mailers/password_mailer

class Identity::PasswordMailerPreview < ActionMailer::Preview
  def password_reset
    user = User.first

    Identity::PasswordMailer.with(
        user: user,
        token: user.generate_token_for(:password_reset)
      ).password_reset
  end
end
