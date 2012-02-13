require 'test_helper'

class Admin::BidsControllerTest < ActionController::TestCase
  setup do
    @admin_bid = admin_bids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_bids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_bid" do
    assert_difference('Admin::Bid.count') do
      post :create, admin_bid: @admin_bid.attributes
    end

    assert_redirected_to admin_bid_path(assigns(:admin_bid))
  end

  test "should show admin_bid" do
    get :show, id: @admin_bid
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_bid
    assert_response :success
  end

  test "should update admin_bid" do
    put :update, id: @admin_bid, admin_bid: @admin_bid.attributes
    assert_redirected_to admin_bid_path(assigns(:admin_bid))
  end

  test "should destroy admin_bid" do
    assert_difference('Admin::Bid.count', -1) do
      delete :destroy, id: @admin_bid
    end

    assert_redirected_to admin_bids_path
  end
end
