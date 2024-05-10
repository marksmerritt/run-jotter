class CreateSignIns < ActiveRecord::Migration[7.1]
  def change
    create_table :sign_ins do |t|
      t.references :user, null: false, foreign_key: true
      t.string :ip
      t.string :user_agent
      t.string :referer

      t.timestamps
    end
  end
end
