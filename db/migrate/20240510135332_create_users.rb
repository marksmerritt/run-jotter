class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :username, null: false, index: { unique: true }
      t.string :email, null: false, index: { unique: true }
      t.datetime :email_verified_at
      t.string :password_digest
      t.string :time_zone

      t.timestamps
    end
  end
end
