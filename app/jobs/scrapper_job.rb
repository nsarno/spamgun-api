class ScrapperJob < ActiveJob::Base
  queue_as :default

  def perform source, max_page=1
    source.scrap max_page
  end
end
