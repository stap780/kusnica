class AddColumnStatusEbayStatusEtsyToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :status_ebay, :boolean
    add_column :products, :status_etsy, :boolean
  end
end
