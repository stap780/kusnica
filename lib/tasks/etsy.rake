# -*- encoding : utf-8 -*-
namespace :etsy do
  desc "work with etsy"

  task get_auth_data: :environment do
    require 'etsy'
    # эти данные берём из настроек etsy приложения и сохраняем
    Etsy.api_key = '2cewf5lip5r8640r36uf1m4p'
    Etsy.api_secret = 'o9lx3tfkye'
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
    token = access_data.token # 6017feeb76b0af19aa9be6141be177
    secret = access_data.secret # d087734a25
    #________________#
    # установка и настройка работы по api закончена #


    # Алгоритм работы по API #
    Etsy.api_key = '2cewf5lip5r8640r36uf1m4p'
    Etsy.api_secret = 'o9lx3tfkye'
    # token - из базы данных
    # secret - из базы данных
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


end