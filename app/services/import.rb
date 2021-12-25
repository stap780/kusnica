class Services::Import

  def self.product
    require 'open-uri'
    puts '=====>>>> СТАРТ InSales YML '+Time.now.to_s

    Product.update_all(quantity: 0)
    Product.update_all(price_dollar: nil)

    url = "https://kusnica.ru/marketplace/88195.xml?lang=eng"
    filename = url.split('/').last
    download = open(url)
		download_path = "#{Rails.public_path}"+"/"+filename
		IO.copy_stream(download, download_path)
    # response = RestClient.get url, :accept => :xml, :content_type => "application/xml"
    data = Nokogiri::XML(open(download_path))
    offers = data.xpath("//offer")

    categories = {}
    doc_categories = data.xpath("//category")
    doc_categories.each do |c|
      categories[c["id"]] = c.text
    end

    offers.each_with_index do |pr, i|
      params = pr.xpath("param").present? ? pr.xpath("param").map{ |p| p["name"]+":"+p.text }.join(' --- ') : ''
      price_dollar = pr.xpath("param").map{ |p| p.text if p["name"] == "Цена EBAY" }.reject(&:blank?)[0]
      # puts price_dollar.to_s

      data = {
        sku: pr.xpath("sku").text,
        title: pr.xpath("model").text,
        url: pr.xpath("url").text,
        desc: pr.xpath("description").text,
        image: pr.xpath("picture").map(&:text).join(' '),
        cat: categories[pr.xpath("categoryId").text],
        price: pr.xpath("price").text.to_f,
        price_dollar: price_dollar.to_f,
        oldprice: pr.xpath("oldprice").text.to_f,
        parametr: params,
        ins_id: pr["group_id"],
        ins_var_id: pr["id"]
      }

      product = Product.find_by(ins_var_id: data[:ins_var_id])

      product.present? ? product.update(data) : Product.create!(data)

      break if Rails.env.development? && i == 100

    end

    File.delete(download_path) if File.file?(download_path).present?

    puts '=====>>>> FINISH InSales YML '+Time.now.to_s

    current_process = "=====>>>> FINISH InSales YML - #{Time.now.to_s} - Начинаем обновление остатков"
  	ProductMailer.notifier_process(current_process).deliver_now
  end

  def self.product_quantity
    require 'open-uri'
    puts '=====>>>> СТАРТ InSales EXCEL '+Time.now.to_s
    url = "https://kusnica.ru/marketplace/88178.xls"
		filename = url.split('/').last
    download = open(url)
		download_path = "#{Rails.public_path}"+"/"+filename
		IO.copy_stream(download, download_path)
    spreadsheet = Roo::Excel.new(download_path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      data = {
        ins_var_id: row["ID варианта"].to_s,
        quantity: row["Остаток: Офис"].to_s
      }

      product = Product.find_by(ins_var_id: data[:ins_var_id])

      product.update(data) if product.present?

    end
    Product.where(quantity: nil).update_all(quantity: 0)
    File.delete(download_path) if File.file?(download_path).present?

    puts '=====>>>> FINISH InSales EXCEL '+Time.now.to_s

    current_process = "=====>>>> FINISH InSales EXCEL - #{Time.now.to_s} - Закончили обновление остатков"
  	ProductMailer.notifier_process(current_process).deliver_now
  end

end
