class SpammerJob < ActiveJob::Base
  queue_as :default

  around_perform do |job, block|
    record = job.arguments.first
    record.running!
    block.call
    record.completed!
  end

  def perform record
    max_index = record.source.spam_max
    record.source.ads.where(status: Ad.statuses[:pending]).each_with_index do |ad, index|
      ad.reply
      break unless (max_index == 0  || index < max_index)
    end
  end
end
