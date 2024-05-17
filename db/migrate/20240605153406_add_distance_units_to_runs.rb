class AddDistanceUnitsToRuns < ActiveRecord::Migration[7.1]
  def change
    add_column :runs, :distance_units, :integer
  end
end
