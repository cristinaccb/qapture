class AddQrCodeDataToQrCodes < ActiveRecord::Migration[7.1]
  def change
    add_column :qr_codes, :qr_code_data, :text
  end
end
