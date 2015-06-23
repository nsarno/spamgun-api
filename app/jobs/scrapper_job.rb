class ScrapperJob < ActiveJob::Base
  queue_as :default

  around_perform do |job, block|
    record = job.arguments.first
    record.running!
    block.call
    record.completed!
  end

  def perform record, max_page=1
    record.source.scrap max_page
  end
end
