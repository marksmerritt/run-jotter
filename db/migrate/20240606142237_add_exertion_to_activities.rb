class AddExertionToActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :exertion, :integer, null: false, default: 0
  end
end
