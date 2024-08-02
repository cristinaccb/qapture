class AddFileToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :file, :string
  end
end
