require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get revenue" do
    get dashboards_revenue_url
    assert_response :success
  end

  test "should get orders" do
    get dashboards_orders_url
    assert_response :success
  end
end
