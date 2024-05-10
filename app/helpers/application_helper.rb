module ApplicationHelper
  def priority_time_zones
    [
      "Eastern Time (US & Canada)",
      "Central Time (US & Canada)",
      "Mountain Time (US & Canada)",
      "Pacific Time (US & Canada)",
      "Hawaii",
      "Alaska"
    ].map { |tz_name| ActiveSupport::TimeZone[tz_name] }
  end
end
