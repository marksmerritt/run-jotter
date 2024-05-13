class Identity::BaseController < ApplicationController
	layout "identity"

	before_action :redirect_if_signed_in

	private

	def redirect_if_signed_in
		return unless user_signed_in?

		redirect_to dashboard_path
	end
end
