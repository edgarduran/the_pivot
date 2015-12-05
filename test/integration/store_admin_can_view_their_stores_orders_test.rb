require 'test_helper'

class StoreAdminCanViewTheirStoresOrdersTestTest < ActionDispatch::IntegrationTest
  test "store admin sees orders for their store" do
    skip
    login_store_admin
  end

  test "store admin sees dashboard with their stores orders" do
    create_user
    create_user_order(1)
    login_platform_admin

    assert page.has_content?("Welcome, Admin!")

    within(".all-orders") do
      assert page.has_content?("Status")
      assert page.has_content?("Total Price")
      assert page.has_content?("$200")
      assert page.has_link?("View Order")
    end
  end

  test "store admin sees number of orders by status" do
    create_user
    create_user_order(2)

    login_platform_admin

    within(".by-status") do
      assert page.has_content?("Ordered")
      assert page.has_content?("Canceled")
      assert page.has_content?("Completed")
      assert page.has_content?("2")
    end
  end
end
