class CreateQrCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :qr_codes do |t|
      t.references :event, null: false, foreign_key: true
      t.string :qrCodeUrl

      t.timestamps
    end
  end
end
