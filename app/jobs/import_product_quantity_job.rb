class ImportProductQuantityJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    Services::Import.product_quantity
  end
end
