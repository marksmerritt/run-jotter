class RenameDistanceUnitsToDistanceUnit < ActiveRecord::Migration[7.1]
  def change
    rename_column :runs, :distance_units, :distance_unit
  end
end
