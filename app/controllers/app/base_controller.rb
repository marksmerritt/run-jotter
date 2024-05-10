class App::BaseController < ApplicationController
  layout "app"

  before_action :authenticate_user!
end
