class ProductMailer < ApplicationMailer
layout 'product_mailer'

  def notifier_process(process)
  		@process = process

  	mail to: "info@ketago.com",
  	     cc: "zakaz@teletri.ru",
  	     subject: "Оповещение о процессе",
  	     from: "advt@teletri.ru",
  	     reply_to: "advt@teletri.ru"
  end


end
