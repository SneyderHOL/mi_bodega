class ChangeQrCodeTypeInBox < ActiveRecord::Migration[6.1]
  def change
    change_column :boxes, :qr_code, :text
  end
end
