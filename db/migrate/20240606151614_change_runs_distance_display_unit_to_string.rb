class ChangeRunsDistanceDisplayUnitToString < ActiveRecord::Migration[7.1]
  def change
    change_column :runs, :distance_display_unit, :string
  end
end
