module Distanceable
  extend ActiveSupport::Concern

  METERS_IN_A_KILOMETER = 1000
  METERS_IN_A_MILE = 1609.344
  METERS_IN_A_YARD = 0.9144

  included do
    enum distance_display_unit: %w[ miles kilometers meters yards ].index_by(&:itself), _prefix: :display_distance_in

    before_validation :normalize_distance
  end

  private
    def normalize_distance
      return unless distance && distance_display_unit

      self.distance = distance_in_meters
    end

    def distance_in_meters
      case distance_display_unit
      when "meters"
        distance
      when "yards"
        distance * Distanceable::METERS_IN_A_YARD
      when "kilometers"
        distance * Distanceable::METERS_IN_A_KILOMETER
      when "miles"
        distance * Distanceable::METERS_IN_A_MILE
      end
    end
end
