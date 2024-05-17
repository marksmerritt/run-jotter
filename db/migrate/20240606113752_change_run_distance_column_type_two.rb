class ChangeRunDistanceColumnTypeTwo < ActiveRecord::Migration[7.1]
  def change
    change_column :runs, :distance, :decimal, precision: 12, scale: 4
  end
end
