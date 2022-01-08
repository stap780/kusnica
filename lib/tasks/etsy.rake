# -*- encoding : utf-8 -*-
namespace :etsy do
  desc "work with etsy"

    task get_auth_data: :environment do
      require 'etsy'
      # эти данные берём из настроек etsy приложения и сохраняем
      Etsy.api_key = Rails.application.secrets.etsy_api_key
      Etsy.api_secret = Rails.application.secrets.etsy_api_secret
      #________________#

      Etsy.protocol = "https"

      # создаём урл для разрешения доступа к магазину etsy
      request = Etsy.request_token
      verification_url = Etsy.verification_url
      puts verification_url

      # в браузер вставляем verification_url и получаем code. потом используем его
      code = '3d26737d'
      access_data = Etsy.access_token(request.token, request.secret, code )
      puts access_data.token

      # сохраняем token и secret для последующий работы по api с etsy
      token = access_data.token # Rails.application.secrets.etsy_token
      secret = access_data.secret # Rails.application.secrets.etsy_secret
      #________________#
      # установка и настройка работы по api закончена #


      # Алгоритм работы по API #
      Etsy.api_key = Rails.application.secrets.etsy_api_key
      Etsy.api_secret = Rails.application.secrets.etsy_api_secret
      token = EtsySetup.first.token # из базы данных
      secret = EtsySetup.first.secret # из базы данных
      account_data = Etsy.myself(token, secret)
      # второй вариант получения листинга
      access = { access_token: token, access_secret: secret }
      listings = Etsy::Listing.find_all_by_shop_id(account_data.shop.id, access.merge(:limit => 5))
      # userID = account_data.result['user_id'] # '448860603'
      # loginNAME = account_data.result['login_name'] # 'y5uzpb86os0njyct'
      # user = Etsy.user(loginNAME)
      # shop = user.shop
      # puts shop.title
      # первый вариант получения листинга выдаёт 25 шт
      # listings = shop.listings

    end

    task create: :environment do
      require 'etsy'
      Etsy.api_key = Rails.application.secrets.etsy_api_key
      Etsy.api_secret = Rails.application.secrets.etsy_api_secret
      token = EtsySetup.first.token
      secret = EtsySetup.first.secret
      account_data = Etsy.myself(token, secret)
      access = { access_token: token, access_secret: secret }
      shipping_template = Etsy::ShippingTemplate.find_by_user(user, access)
      data = { title: 'тестовый продукт', quantity: 1, description: 'тестовый продукт описание', price: 100, who_made: 'i_did', when_made: '2020_2022', taxonomy_id: 2354, is_supply: false, language: 'ru',
        shipping_template_id: 165706336370 }

      listing = Etsy::Listing.create( access.merge(data) )
      listing_id = JSON.parse(listing.body)['results'][0]['listing_id']
    end

end
