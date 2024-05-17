class Identity::SignUpsController < Identity::BaseController
  before_action :redirect_if_signed_in
  invisible_captcha only: [ :create ], on_spam: :redirect_after_spam

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)

    if @user.save
      sign_in @user
      redirect_to after_sign_in_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if current_user.update(sign_up_params)
      redirect_to calendar_weekly_path, notice: "Info updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def sign_up_params
      params.require(:user).permit(:email, :password, :time_zone)
    end
end
