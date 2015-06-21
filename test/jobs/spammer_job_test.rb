require 'test_helper'
require 'ad'

class Mechanize
  class Form
    def submit
      true
    end
  end
end

class Ad
  def sent? response_page
    true
  end
end

class SpammerJobTest < ActiveJob::TestCase
  test 'ads are being replied to' do
    ScrapperJob.perform_now # scrap some ads

    pending_ads = Ad.where(status: Ad.statuses[:pending]).count
    completed_ads = Ad.where(status: Ad.statuses[:completed]).count

    SpammerJob.perform_now

    assert Ad.where(status: Ad.statuses[:pending]).count < pending_ads
    assert Ad.where(status: Ad.statuses[:completed]).count > completed_ads
  end
end
