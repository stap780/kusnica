class AddColumnPriceDollarToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :price_dollar, :decimal
  end
end
