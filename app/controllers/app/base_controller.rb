class App::BaseController < ApplicationController
  layout "app"

  before_action :authenticate_user!

  private

  def default_time_zone
    "Eastern Time (US & Canada)"
  end
end
