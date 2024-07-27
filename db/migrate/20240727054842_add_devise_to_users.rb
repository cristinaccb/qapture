class AddDeviseToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: "", if_not_exists: true
      t.string :encrypted_password, null: false, default: "", if_not_exists: true

      ## Recoverable
      t.string   :reset_password_token, if_not_exists: true
      t.datetime :reset_password_sent_at, if_not_exists: true

      ## Rememberable
      t.datetime :remember_created_at, if_not_exists: true

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false, if_not_exists: true
      t.datetime :current_sign_in_at, if_not_exists: true
      t.datetime :last_sign_in_at, if_not_exists: true
      t.string   :current_sign_in_ip, if_not_exists: true
      t.string   :last_sign_in_ip, if_not_exists: true

      ## Confirmable
      t.string   :confirmation_token, if_not_exists: true
      t.datetime :confirmed_at, if_not_exists: true
      t.datetime :confirmation_sent_at, if_not_exists: true
      t.string   :unconfirmed_email, if_not_exists: true # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false, if_not_exists: true # Only if lock strategy is :failed_attempts
      t.string   :unlock_token, if_not_exists: true # Only if unlock strategy is :email or :both
      t.datetime :locked_at, if_not_exists: true

      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false, if_not_exists: true
    end

    add_index :users, :email,                unique: true, if_not_exists: true
    add_index :users, :reset_password_token, unique: true, if_not_exists: true
    add_index :users, :confirmation_token,   unique: true, if_not_exists: true
    add_index :users, :unlock_token,         unique: true, if_not_exists: true
  end
end
