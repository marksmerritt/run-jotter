class Identity::PasswordResetsController < Identity::BaseController
  before_action :verify_user_not_signed_in
  before_action :set_user_by_token, only: [ :edit, :update ]

  def new
  end

  def create
    if user = User.find_by_email(params[:email])
      user.send_password_reset_mailer
    end

    redirect_to root_path, notice: "Check your email to reset your password"
  end

  def edit
  end

  def update
    if @user.update(password_params)
      redirect_to sign_in_path, notice: "Your password has been reset successfully. Please sign in."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def verify_user_not_signed_in
    redirect_back fallback_location: root_path, notice: "You are already signed in" if user_signed_in?
  end

  def set_user_by_token
    @user = User.find_by_token_for(:password_reset, params[:token])
    redirect_to new_password_reset_path, alert: "Invalid token. Please request a new password reset email." unless @user.present?
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
