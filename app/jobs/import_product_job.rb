class ImportProductJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    Services::Import.full_import
  end
end
