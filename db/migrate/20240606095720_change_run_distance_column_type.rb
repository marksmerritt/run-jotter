class ChangeRunDistanceColumnType < ActiveRecord::Migration[7.1]
  def change
    change_column :runs, :distance, :bigint
  end
end
