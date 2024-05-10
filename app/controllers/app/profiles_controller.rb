class App::ProfilesController < App::BaseController
	def edit
	end

	def update
		if current_user.update(profile_params)
			redirect_to profile_path, notice: "Profile updated"
		else
			render :edit, status: :unprocessable_entity
		end
	end

	private

	def profile_params
		params.require(:user).permit(:username, :time_zone)
	end
end
