class AddStartsAtToActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :starts_at, :datetime, null: false
  end
end
