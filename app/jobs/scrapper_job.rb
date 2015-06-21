class ScrapperJob < ActiveJob::Base
  queue_as :default

  def perform max_page=1
    Source.find_each do |source|
      source.scrap max_page
    end
  end
end
