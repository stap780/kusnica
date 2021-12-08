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
		if v.to_i == 1
			value = Array(1..default_v)
		end
	end

def self.create_ebay_file(products, type)
	  puts "Файл decor инсалес"

		file = "#{Rails.public_path}"+'/'+type+'.csv'
		check = File.file?(file)
		File.delete(file) if check.present?

    new_file = "#{Rails.public_path}"+'/complete_'+type+'.csv'
		check = File.file?(file)
		File.delete(file) if check.present?

		#создаём файл со статичными данными
		@products = Product.where(id: products)#.limit(10000).offset(20000) #where('title like ?', '%Bellelli B-bip%')
		CSV.open( file, 'w') do |writer|
      images = Array(1..10).map{|a| "Picture URL "+a.to_s}
      vparamHeader = []
      parametrs = @products.where.not(parametr: nil).pluck(:parametr).reject(&:blank?)
      parametrs.each do |p|
  			p.split('---').each do |pa|
  				vparamHeader << pa.split(':')[0].strip if pa != nil
  			end
  		end
      count_parametr = vparamHeader.uniq.count
      header_parametr = []
      Array(1..count_parametr).each do |a|
        header_parametr << 'Attribute Name '+a.to_s
        header_parametr << 'Attribute Value '+a.to_s
      end

      header = ['SKU','Localized For','Title', 'Product Description', 'Condition', 'List Price'].concat(images).concat(header_parametr)

  		writer << header

		  @products.each do |pr|
			title = pr.title.present? ? pr.title.strip : ''
			images_pr = pr.image.present? ? pr.image.split(' ') : []
      add_count = 10-images_pr.count
      add_array = Array(1..add_count).map{|a| ""}
      images = images_pr.count < 10 ? images_pr.concat(add_array) : images_pr.first(10)

			price = pr.price.present? ? pr.price.to_s : '0'
			quantity = pr.quantity.present? ?  pr.quantity : ''
			desc = pr.desc.present? ? pr.desc : ''
			ins_id = pr.ins_id.present? ? pr.ins_id : pr.sku

			writer << [ins_id, 'en_US', title, desc, 'NEW', price].concat(images)

			end
		end #CSV.open

    # заполняем параметры по каждому товару в файле
		CSV.open(new_file, "w") do |csv_out|
			rows = CSV.read(file, headers: true).collect do |row|
				row.to_hash
			end
			column_names = rows.first.keys
			csv_out << column_names
			CSV.foreach(file, headers: true ) do |row|
				ins_id = row[0]
				puts ins_id
				vel = Product.where(ins_id: ins_id).where.not(parametr: nil ).first
	 			# Вид записи должен быть типа - "Длина рамы: 20 --- Ширина рамы: 30"
				if vel.present?
  				vel.parametr.split('---').each_with_index do |vp, index|
  					key_param_name = 'Attribute Name '+(index+1).to_s
  					value_param_name = vp.split(':')[0].present? ? vp.split(':')[0].strip : ''
  					# puts value_param_name
  					row[key_param_name] = value_param_name
            key_param_val = 'Attribute Value '+(index+1).to_s
  					value_param_val = vp.split(':')[1].present? ? vp.split(':')[1].strip : ''
  					# puts value_param_val
  					row[key_param_val] = value_param_val
  				end
				end
# 				row['Полное описание'] = vel.desc.present? ? vel.desc.split().join : ''
				csv_out << row
			end
		end


	puts "Finish Файл nail инсалес"

	current_process = "создаём файл csv_param Decor"
	# CaseMailer.notifier_process(current_process).deliver_now

	end



def normalize_data_white_space
  self.attributes.each do |key, value|
    self[key] = value.squish if value.respond_to?("squish")
  end
end

end
