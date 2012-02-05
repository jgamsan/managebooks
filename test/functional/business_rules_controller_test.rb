require 'test_helper'

class BusinessRulesControllerTest < ActionController::TestCase
  setup do
    @business_rule = business_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:business_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create business_rule" do
    assert_difference('BusinessRule.count') do
      post :create, business_rule: @business_rule.attributes
    end

    assert_redirected_to business_rule_path(assigns(:business_rule))
  end

  test "should show business_rule" do
    get :show, id: @business_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @business_rule
    assert_response :success
  end

  test "should update business_rule" do
    put :update, id: @business_rule, business_rule: @business_rule.attributes
    assert_redirected_to business_rule_path(assigns(:business_rule))
  end

  test "should destroy business_rule" do
    assert_difference('BusinessRule.count', -1) do
      delete :destroy, id: @business_rule
    end

    assert_redirected_to business_rules_path
  end
end
