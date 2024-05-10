class Identity::EmailVerificationsController < Identity::BaseController
	before_action :set_user, only: [:new, :create]
  before_action :set_user_by_token, only: [:edit, :update]

  def new
  end

  def create
    @user.send_email_verification_mailer

    redirect_to root_path, notice: "Email verification email sent"
  end

  def edit
    if current_user == @user
      @user.email_verified!

      redirect_to dashboard_path, notice: "Email verified"
    end
  end

  def update
    if @user.update(email_verification_params)
      @user.email_verified!
      sign_in @user

      redirect_to after_sign_in_url, notice: "Your email address has been verified"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
  	@user = User.find(params[:user_id])
  end

  def set_user_by_token
    @user = User.find_by_token_for(:email_verification, params[:token])
    redirect_to sign_in_path, alert: "Invalid token" unless @user.present?
  end

  def email_verification_params
    params.require(:user).permit(:password_challenge)
          .with_defaults(password_challenge: "")
  end
end
