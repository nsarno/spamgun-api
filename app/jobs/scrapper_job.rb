class ScrapperJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Source.find_each do |source|
      source.scrap
    end
  end
end
