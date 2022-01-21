class EtsyProductJob < ApplicationJob
  queue_as :default

  def perform(products_ids)
    # Do something later
    Services::Etsy.create_update_products(products_ids)
  end
end
