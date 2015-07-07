require 'test_helper'

class AdTest < ActiveSupport::TestCase
  test 'has a unique uid per hostname' do
    ad = ads(:one)

    dup = Ad.new uid: ad.uid, hostname: ad.hostname
    assert_not dup.valid?

    dup = Ad.new uid: ad.uid, hostname: 'other', source: ad.source
    assert dup.valid?
  end

  test 'validates presence of uid' do
    ad = ads(:one)

    ad_without_uid = Ad.new
    assert_not ad_without_uid.valid?
    assert ad_without_uid.errors.messages[:uid].any?
  end

  test 'validates presence of source' do
    ad = ads(:one)

    ad_without_source = Ad.new uid: 42

    assert_not ad_without_source.valid?
    assert ad_without_source.errors.messages[:source_id].any?
  end
end
