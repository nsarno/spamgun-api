require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'have a username' do
    assert User.new(username: nil).valid? == false
  end

  test 'have a unique username' do
    assert User.new(username: users(:one).username).valid? == false
  end
end
