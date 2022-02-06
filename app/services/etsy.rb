class Services::Etsy
  require 'open-uri'

  Etsy.api_key = EtsySetup.first.api_key
  Etsy.api_secret = EtsySetup.first.api_secret
  token = EtsySetup.first.token
  secret = EtsySetup.first.secret
  @account = Etsy.myself(token, secret)
  @access = { access_token: token, access_secret: secret }


  def self.create_update_products(product_ids)
    product_ids.each do |product_id|
      Services::Etsy.create_update_one(product_id)
    end

    current_process = "=====>>>> FINISH ETSY create_update_products - #{Time.now.to_s}"
  	ProductMailer.notifier_process(current_process).deliver_now
  end

  def self.create_update_one(product_id)
    product = Product.find(product_id)
    # puts "product.id.to_s - "+product.id.to_s
    # puts product.etsy_id.is_a?String
    # puts "product.etsy_id.to_s - "+product.etsy_id.to_s
    data = {
      title: product.title_en,
      sku: product.ins_id,
      quantity: product.quantity,
      description: product.desc_en,
      price: product.price_etsy,
      who_made: 'i_did',
      when_made: '2020_2022',
      taxonomy_id: 2354,
      is_supply: false,
      language: 'ru',
      shipping_template_id: 165706336370
    }
    if product.etsy_id.present?
      listing = Etsy::Listing.find( product.etsy_id )
      Etsy::Listing.update( listing, @access.merge(data) )
    else
      listing = Etsy::Listing.create( @access.merge(data) )
      listing_id = JSON.parse(listing.body)['results'][0]['listing_id']
      product.etsy_id = listing_id
      product.save
    end
    Services::Etsy.update_image(product_id)
  end

  def self.update_image(product_id)
    product = Product.find(product_id)
    listing = Etsy::Listing.find( product.etsy_id )
    images = product.image.split(' ')
    if images.present?
      images.each do |image|
        filename = image.split('/').last
        download_path = "#{Rails.public_path}"+"/"+filename
        download = open(image)
        IO.copy_stream(download, download_path)

        Etsy::Image.create( listing, download_path, @access )

        File.delete(download_path) if File.file?(download_path).present?
      end
    end
  end

  def self.get_listings_count
    listings = Etsy::Listing.find_all_by_shop_id(@account.shop.id, @access.merge(:limit => 500))
    puts "Всего товаров - "+listings.count.to_s
  end

end
