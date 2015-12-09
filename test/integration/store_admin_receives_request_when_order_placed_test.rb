require "test_helper"

class StoreAdminReceivesRequestWhenOrderPlacedTest < ActionDispatch::IntegrationTest
  def setup
    create_user
    create_user_order(1)
    login_store_admin
  end

  test "store admin can approve pending orders" do
    order = Order.first

    assert page.has_content?("Pending Orders")
    assert page.has_content?("Matt")
    assert_equal "pending", order.current_status

    click_link "Approve Order"
    assert_equal "ordered", order.current_status
  end

  test "store admin can decline pending orders" do
    skip
    order = Order.first

    assert page.has_content?("Pending Orders")
    assert page.has_content?("Matt")
    assert_equal "pending", order.current_status

    click_link "Decline Order"
    assert_equal "canceled", order.current_status
  end
end
