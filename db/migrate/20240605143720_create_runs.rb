class CreateRuns < ActiveRecord::Migration[7.1]
  def change
    create_table :runs do |t|
      t.integer :kind, null: false
      t.integer :distance
      t.integer :elevation

      t.timestamps
    end
  end
end
