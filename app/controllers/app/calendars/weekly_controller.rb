class App::Calendars::WeeklyController < App::BaseController
	def show
    set_dates
    @selected_date = params[:selected_date]&.to_date || Date.current
    @activities = {}

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private

  def set_dates
    if params[:direction]
      if params[:direction] == "up"
        @end_date = (params[:start_date].to_date - 1.day).to_time
        @start_date = (@end_date - 4.weeks).beginning_of_week.to_time
      else
        @start_date = (params[:start_date].to_date + 1.day).to_time
        @end_date = (@start_date + 4.weeks).end_of_week.to_time
      end
    else
      @start_date = params[:start_date]&.to_time || 4.weeks.ago.beginning_of_week
      @end_date = params[:end_date]&.to_time || 4.weeks.from_now.end_of_week
    end
  end
end
