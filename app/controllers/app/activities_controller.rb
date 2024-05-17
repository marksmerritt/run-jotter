class App::ActivitiesController < App::BaseController
  def new
    @selected_date = params[:selected_date]
    @activity = Current.user.activities.new

    respond_to do |format|
      format.html
      format.turbo_stream
    end
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
      params.require(:activity).permit(:title, :started_at, :duration, :exertion, :description,
                                       :activityable_type,
                                       activityable_attributes: [ :kind, :distance, :distance_display_unit, :elevation, :elevation_display_unit ])
    end
end
