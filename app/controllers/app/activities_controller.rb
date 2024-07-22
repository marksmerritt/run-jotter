class App::ActivitiesController < App::BaseController
	def new
		@selected_day = params[:selected_day]
		@activity = Current.user.activities.new
	end

	def create
		@activity = Current.user.activities.new(activity_params)

		respond_to do |format|
			if @activity.save
				format.turbo_stream
			else
				format.html { render :new, status: :unprocessable_entity }
			end
		end
	end

	private

	def activity_params
		params.require(:activity).permit(:starts_at, :title)
	end
end
