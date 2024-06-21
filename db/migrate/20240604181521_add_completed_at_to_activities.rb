class AddCompletedAtToActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :completed_at, :datetime
  end
end
