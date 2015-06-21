require 'test_helper'

class AdsControllerTest < ActionController::TestCase
  setup do
    @ad = ads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ads)
  end

  # test "should create ad" do
  #   assert_difference('Ad.count') do
  #     post :create, ad: { source: @ad.source, uid: SecureRandom.hex(10) }
  #   end

  #   assert_response 201
  # end

  test "should show ad" do
    get :show, id: @ad
    assert_response :success
  end

  # test "should update ad" do
  #   put :update, id: @ad, ad: { source: @ad.source, uid: SecureRandom.hex(10) }
  #   assert_response 204
  # end

  # test "should destroy ads" do
  #   assert_difference('Ad.count', -1) do
  #     delete :destroy, id: @ad
  #   end

  #   assert_response 204
  # end
end
