class ImportProductJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    Services::Import.xml_import
  end
end
