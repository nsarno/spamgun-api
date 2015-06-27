require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test 'should issue an auth token' do
    post :create, login: { username: @user.username, password: 'secret' }
    assert_response :created
  end

end
