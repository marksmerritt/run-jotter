class Identity::GoogleAccountsController < Identity::BaseController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :redirect_if_signed_in
  before_action :validate_google_csrf, only: [:create]
  before_action :set_google_account, only: [:edit, :update]

  def create
    google_account_connection = GoogleAccountConnection.new(credential: params[:credential])

    if google_account_connection.perform
      if google_account_connection.google_account.connected?
        sign_in google_account_connection.user
        redirect_to after_sign_in_url
      elsif google_account_connection.google_account.pending_verification?
        redirect_to edit_google_account_path(google_account_connection.google_account)
      end
    else
      redirect_to sign_in_path, notice: "Something went wrong. Please try again."
    end

  rescue Google::Auth::IDTokens::SignatureError, Google::Auth::IDTokens::AudienceMismatchError, Google::Auth::IDTokens::VerificationError
    redirect_to sign_in_path, notice: "Invalid token"
  end

  def edit
  end

  def update
    if user = User.authenticate_by(email: @google_account.email, password: params[:user][:password])
      @google_account.connected!
      sign_in user

      redirect_to after_sign_in_url, notice: "Your google account has been connected"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def validate_google_csrf
    if cookies["g_csrf_token"].blank? ||
       params["g_csrf_token"].blank? ||
       cookies["g_csrf_token"] != params["g_csrf_token"]

       raise Google::Auth::IDTokens::VerificationError
    end
  end

  def set_google_account
    @google_account = GoogleAccount.find(params[:id])
  end
end
