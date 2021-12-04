class ProductJob < ActiveJob::Base
  queue_as :default

  def xml_import
    Services::ImportProduct.xml_import
  end

end
