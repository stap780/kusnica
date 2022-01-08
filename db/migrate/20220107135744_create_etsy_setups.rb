class CreateEtsySetups < ActiveRecord::Migration[5.2]
  def change
    create_table :etsy_setups do |t|
      t.string :api_key
      t.string :api_secret
      t.string :code
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
