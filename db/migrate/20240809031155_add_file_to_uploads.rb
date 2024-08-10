class AddFileToUploads < ActiveRecord::Migration[7.1]
  def change
    add_column :uploads, :file, :string
  end
end
