class ImportProductJob < ActiveJob::Base
  queue_as :default

  def perform
    Services::ImportProduct.xml_import
  end

end
