class SpammerJob < ActiveJob::Base
  queue_as :default

  def perform
    Ad.where(status: 'pending').find_each do |ad|
      ad.reply
    end
  end
end