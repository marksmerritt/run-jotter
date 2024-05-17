class AddDurationToActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :duration, :integer
  end
end
