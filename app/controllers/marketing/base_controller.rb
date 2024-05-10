class Marketing::BaseController < ApplicationController
	layout "marketing"

	before_action :redirect_to_dashboard, if: :user_signed_in?

	private

	def redirect_to_dashboard
		redirect_to dashboard_path
	end
end
