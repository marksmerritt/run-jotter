class ChangeActivityNameToTitle < ActiveRecord::Migration[7.1]
  def change
    rename_column :activities, :name, :title
  end
end
