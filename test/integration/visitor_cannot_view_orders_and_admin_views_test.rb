require "test_helper"

class VisitorCannotViewOrdersAndAdminViewsTest < ActionDispatch::IntegrationTest
  test "an unauthenticated user cannot view any orders" do
    login_user
    create_user_order(1)

    visit "/orders"

    assert page.has_content?("Your Orders")
    assert page.has_content?("ordered")

    click_link("View Order")

    within(".orders-table") do
      assert page.has_content?("$200")
      assert page.has_content?("1960 Chevy0 El Camino0")
    end

    click_link("Logout")

    visit "/orders"

    assert_equal "/", current_path
  end

  test "an unauthenticated user cannot view a users cart" do
    login_user
    add_car_to_cart

    within(".cart-count") do
      assert page.has_content?("1")
    end

    visit "/cart"

    within(".total_price") do
      assert page.has_content?("$100")
    end

    logout_user
    create_and_login_additional_user

    within(".cart-count") do
      assert page.has_content?("0")
    end

    visit "/cart"

    within(".total_price") do
      refute page.has_content?("$100")
    end
  end

  test "an unauthenticated user cannot view a users dashboard" do
    create_user
    old_user = User.first

    visit "/users/#{old_user.id}"

    assert_equal "/", current_path
  end

  test "an unauthenticated user cannot view platform admin dashboard" do
    create_platform_admin

    visit admin_dashboard_path(User.last)

    assert_equal "/", current_path
  end

  test "an unauthenticated user cannot view store admin dashboard" do
    create_store_admin

    visit admin_dashboard_path(User.last)

    assert_equal "/", current_path
  end

  test "a user cannot make themselves an admin" do
    login_user

    visit admin_dashboard_path(User.last)

    assert_equal "/", current_path
  end
end
