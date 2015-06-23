require 'test_helper'
require 'source'

class Source
  def scrap max_page=1
    true
  end
end

class ScrapperJobTest < ActiveJob::TestCase
  test 'record status is updated' do
    record = jobs(:scrapper)

    assert record.pending?
    ScrapperJob.perform_now record
    assert record.completed?
  end

  test 'ads are created' do
    skip 'skipping scrapping: too slow'
    record = jobs(:scrapper)

    count = Ad.count
    ScrapperJob.perform_now record
    assert Ad.count > count
  end
end
