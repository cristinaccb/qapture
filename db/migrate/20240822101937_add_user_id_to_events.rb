class AddUserIdToEvents < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :host, :string
    add_reference :events, :user, null: false, foreign_key: true
  end
end
