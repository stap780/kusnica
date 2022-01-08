class EtsyService

  def self.create_update(product_id)

    Etsy.api_key = EtsySetup.first.api_key
    Etsy.api_secret = EtsySetup.first.api_secret
    token = EtsySetup.first.token
    secret = EtsySetup.first.secret
    account_data = Etsy.myself(token, secret)
    # access = { access_token: token, access_secret: secret }
    # listings = Etsy::Listing.find_all_by_shop_id(account_data.shop.id, access.merge(:limit => 5))

    product = Product.find(product_id)
    if product.etsy_id.present?

    else

    end

  end

end
