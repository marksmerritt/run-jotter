class App::DatePickersController < App::BaseController
  def show
    @selected_date = params[:selected_date]&.to_date || Date.current

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
