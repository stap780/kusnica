class Product < ApplicationRecord
  before_save :normalize_data_white_space
  validates :ins_var_id , uniqueness: true

  scope :all_product, -> { all.order(:id) }
	scope :all_product_size, -> { all_product.size }
	scope :all_product_not_nil, -> { all_product.where('quantity >= ?', 1) }
	scope :all_product_not_nil_size, -> { all_product_not_nil.size }


  def self.quantity_search(v)
		default_v = Product.pluck(:quantity).uniq.sort.last
		if v == 'all'
			value = Array(0..default_v)
		end
		if v.to_i == 0
			value = Array(0..0)
		end
		if v != 'all' and v.to_i != 0
			value = Array(1..default_v)
		end
	end



def normalize_data_white_space
  self.attributes.each do |key, value|
    self[key] = value.squish if value.respond_to?("squish")
  end
end

end
