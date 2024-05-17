class ChangeRunDistanceColumnTypeThree < ActiveRecord::Migration[7.1]
  def change
    change_column :runs, :distance, :decimal, precision: 16, scale: 8
  end
end
