require 'test_helper'

class IframeControllerTest < ActionController::TestCase
  test "should get get_portfolio_html" do
    get :get_portfolio_html
    assert_response :success
  end

  test "should get get_rule_html" do
    get :get_rule_html
    assert_response :success
  end

  test "should get get_stock_json" do
    get :get_stock_json
    assert_response :success
  end

end
