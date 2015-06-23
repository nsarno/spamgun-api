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
  test 'record status is updated' do
    record = jobs(:spammer)

    assert record.pending?
    SpammerJob.perform_now record
    assert record.completed?
  end

  test 'ads are being replied to' do
    skip 'skipping scrapping: too slow'

    ScrapperJob.perform_now jobs(:scrapper) # scrap some ads

    record = jobs(:spammer)

    assert record.pending?
    pending_ads = Ad.where(status: Ad.statuses[:pending]).count
    completed_ads = Ad.where(status: Ad.statuses[:completed]).count

    SpammerJob.perform_now record

    assert record.completed?
    assert Ad.where(status: Ad.statuses[:pending]).count < pending_ads
    assert Ad.where(status: Ad.statuses[:completed]).count > completed_ads
  end
end
