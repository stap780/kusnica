class ChangeIntegerLimitForEbayEtsy < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :ebay_id, :integer, limit: 8
    change_column :products, :etsy_id, :integer, limit: 8
  end
end
