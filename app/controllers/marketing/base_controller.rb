class Marketing::BaseController < ApplicationController
  layout "marketing"

  before_action :redirect_to_calendar, if: :user_signed_in?

  private
    def redirect_to_calendar
      redirect_to calendar_weekly_index_path
    end
end
