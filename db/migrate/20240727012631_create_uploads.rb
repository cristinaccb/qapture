class CreateUploads < ActiveRecord::Migration[7.1]
  def change
    create_table :uploads do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.string :mediaType
      t.string :mediaUrl
      t.timestamp :timestamp

      t.timestamps
    end
  end
end
