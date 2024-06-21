class AddActivityableToActivities < ActiveRecord::Migration[7.1]
  def change
    add_reference :activities, :activityable, polymorphic: true, null: false
  end
end
