class SpammerJob < ActiveJob::Base
  queue_as :default

  around_perform do |job, block|
    record = job.arguments.first
    record.running!
    block.call
    record.completed!
  end

  def perform record
    record.source.ads.where(status: Ad.statuses[:pending]).find_each do |ad|
      ad.reply
    end
  end
end
