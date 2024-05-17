module FormsHelper
  def options_for_enum(enum_hash)
    options_for_select(enum_hash.map { |k, v| [ k.humanize.titleize, v ] })
  end
end
