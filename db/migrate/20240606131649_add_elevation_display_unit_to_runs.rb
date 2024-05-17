class AddElevationDisplayUnitToRuns < ActiveRecord::Migration[7.1]
  def change
    add_column :runs, :elevation_display_unit, :string
  end
end
