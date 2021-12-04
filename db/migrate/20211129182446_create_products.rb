class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :title
      t.string :desc
      t.string :cat
      t.decimal :oldprice
      t.decimal :price
      t.string :quantity
      t.string :image
      t.string :url
      t.string :parametr
      t.integer :ins_id
      t.integer :ins_var_id
      t.integer :ebay_id
      t.integer :etsy_id

      t.timestamps
    end
  end
end
