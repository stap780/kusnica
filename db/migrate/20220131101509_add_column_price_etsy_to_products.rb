class AddColumnPriceEtsyToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :price_etsy, :decimal
  end
end
