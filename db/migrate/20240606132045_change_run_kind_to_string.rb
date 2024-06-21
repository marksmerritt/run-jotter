class ChangeRunKindToString < ActiveRecord::Migration[7.1]
  def change
    change_column :runs, :kind, :string
  end
end
