class Identity::SignInsController < Identity::BaseController
  before_action :redirect_if_signed_in, except: [:destroy]
  invisible_captcha only: [:create], on_spam: :redirect_after_spam

  def new
  end

  def create
    if user = User.authenticate_by(email: params[:email], password: params[:password])
      sign_in user

      redirect_to after_sign_in_url
    else
      flash[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out current_user
    redirect_to root_path(auto_sign_in: false), notice: "You have been signed out"
  end
end
