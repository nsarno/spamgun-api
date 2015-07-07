require 'test_helper'

class SourceTest < ActiveSupport::TestCase
  test 'validates presence of attributes' do
    s = Source.new
    assert_not s.valid?
  end
end
