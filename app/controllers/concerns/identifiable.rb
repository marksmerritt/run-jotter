module Identifiable
  extend ActiveSupport::Concern

  included do
    before_action :set_time_zone
    helper_method :current_user, :user_signed_in?, :browser_time_zone
  end

  private
    def authenticate_user!
      unless user_signed_in?
        session[:run_jotter_after_sign_in_url] = request.url
        redirect_to sign_in_path, alert: "You must be signed in to do that"
      end
    end

    def current_user
      Current.user ||= authenticate_user_from_cookie
    end

    def authenticate_user_from_cookie
      User.find_by(id: cookies.encrypted[:run_jotter_user_id])
    end

    def user_signed_in?
      current_user.present?
    end

    def redirect_if_signed_in
      return unless user_signed_in?

      redirect_to after_sign_in_url
    end

    def redirect_after_spam
      redirect_to root_path
    end

    def sign_in(user)
      Current.user = user
      cookies.encrypted.permanent[:run_jotter_user_id] = user.id
      user.sign_ins.create(ip: request.ip, user_agent: request.user_agent, referer: request.referer)
    end

    def after_sign_in_url
      session.delete(:run_jotter_after_sign_in_url) || calendar_weekly_index_url
    end

    def sign_out(user)
      Current.user = nil
      reset_session
      cookies.delete :run_jotter_user_id
    end

    def browser_time_zone
      browser_tz = ActiveSupport::TimeZone.find_tzinfo(cookies[:run_jotter_time_zone])
      ActiveSupport::TimeZone.all.find { |zone| zone.tzinfo == browser_tz } || Time.zone
    rescue TZInfo::UnknownTimezone, TZInfo::InvalidTimezoneIdentifier
      Time.zone
    end

    def set_time_zone
      Time.zone = (user_signed_in? && current_user.time_zone) || browser_time_zone.name
    end
end
