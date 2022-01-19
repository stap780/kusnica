class AddColumnTitleEnDescEnToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :title_en, :string
    add_column :products, :desc_en, :string
  end
end
