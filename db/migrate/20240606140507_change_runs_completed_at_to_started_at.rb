class ChangeRunsCompletedAtToStartedAt < ActiveRecord::Migration[7.1]
  def change
    rename_column :activities, :completed_at, :started_at
  end
end
