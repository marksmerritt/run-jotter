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

  def svg_tag(icon_name, options = {})
    file = File.read(Rails.root.join("app", "assets", "images", "#{icon_name}.svg"))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"

    options.each do |attr, value|
      if attr == :data
        value.each do |data_attr, data_value|
          svg["data-#{data_attr.to_s.split('_').join('-')}"] = data_value
        end
      else
        svg[attr.to_s] = value
      end
    end

    doc.to_html.html_safe
  end
end
