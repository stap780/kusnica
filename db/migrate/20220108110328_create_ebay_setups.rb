class CreateEbaySetups < ActiveRecord::Migration[5.2]
  def change
    create_table :ebay_setups do |t|
      t.string :ebay_username
      t.string :ebay_password

      t.timestamps
    end
  end
end
