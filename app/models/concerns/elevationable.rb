module Elevationable
  extend ActiveSupport::Concern

  METERS_IN_A_FOOT = 0.3048

  included do
    enum elevation_display_unit: %w[ feet meters ].index_by(&:itself), _prefix: :display_elevation_in

    before_validation :normalize_elevation
  end

  private
    def normalize_elevation
      return unless elevation && elevation_display_unit

      self.elevation = elevation_in_meters
    end

    def elevation_in_meters
      case elevation_display_unit
      when "meters"
        elevation
      when "feet"
        elevation * Elevationable::METERS_IN_A_FOOT
      end
    end
end
