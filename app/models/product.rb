class Product < ApplicationRecord
  before_save :normalize_data_white_space
  validates :ins_var_id , uniqueness: true



def normalize_data_white_space
  self.attributes.each do |key, value|
    self[key] = value.squish if value.respond_to?("squish")
  end
end

end
