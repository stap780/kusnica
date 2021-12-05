class ChangeQuantityToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :quantity, :integer, using: 'quantity::integer'
  end
end
