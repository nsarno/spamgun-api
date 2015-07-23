require 'test_helper'

class SourcesControllerTest < ActionController::TestCase

  def authenticate
    token = Knock::AuthToken.new(payload: { sub: users(:one).id }).token
    request.env['HTTP_AUTHORIZATION'] = "bearer #{token}"
  end

  setup do
    authenticate
    @source = sources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should create source" do
    assert_difference('Source.count') do
      post :create, source: @source.attributes
    end

    assert_response :created
  end

  test "should show source" do
    get :show, id: @source
    assert_response :success
  end

  test "should update source" do
    put :update, id: @source, source: { title: 'Updated title' }
    assert_response :success
  end

  test "should destroy source" do
    assert_difference('Source.count', -1) do
      delete :destroy, id: @source
    end

    assert_response :no_content
  end
end
