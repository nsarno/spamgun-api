require 'test_helper'

class AdTest < ActiveSupport::TestCase
  test 'has a unique uid per hostname' do
    ad = ads(:one)

    dup = Ad.new uid: ad.uid, hostname: ad.hostname
    assert_not dup.valid?

    dup = Ad.new uid: ad.uid, hostname: 'other'
    assert dup.valid?
  end
end
