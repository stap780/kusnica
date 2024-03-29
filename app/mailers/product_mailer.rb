class ProductMailer < ApplicationMailer
layout 'product_mailer'
default from: Rails.application.secrets.default_from

  def notifier_process(process)
  		@process = process
      search_admin_users = User.order(:id).map{|u| u.email if u.role.name.include?('admin') && u.email != 'user@example.com' }.reject(&:blank?)
      admin_users = search_admin_users.present? ? search_admin_users.join(',') : Rails.application.secrets.default_to
  	mail to: admin_users,
         from: 'kusnicaserver@mail.ru',
  	     subject: "Оповещение о процессе",
  	     reply_to: Rails.application.secrets.default_from
  end


end
