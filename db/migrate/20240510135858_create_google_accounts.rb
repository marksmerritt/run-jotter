class CreateGoogleAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :google_accounts do |t|
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true
      t.string :google_account_id, null: false
      t.string :email, null: false, index: { unique: true }
      t.boolean :email_verified, null: false, default: false
      t.string :picture_url
      t.string :first_name
      t.string :last_name
      t.string :locale

      t.timestamps
    end
  end
end
