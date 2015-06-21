require 'test_helper'

class ScrapperJobTest < ActiveJob::TestCase
  test 'ads are created' do
    ad_count_before  = Ad.count
    ScrapperJob.perform_now
    assert Ad.count > ad_count_before
  end
end
