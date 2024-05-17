class RenameRunDistanceUnitToDistanceDisplayUnit < ActiveRecord::Migration[7.1]
  def change
    rename_column :runs, :distance_unit, :distance_display_unit
  end
end
