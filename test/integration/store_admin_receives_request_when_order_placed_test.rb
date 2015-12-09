require "test_helper"

class StoreAdminReceivesRequestWhenOrderPlacedTest < ActionDispatch::IntegrationTest
  def login_store_admin
    Store.first.update(approved: true)
    User.find_by(username: "Dave").roles.create(name: 'store_admin')

    visit login_path
    fill_in 'Username', with: 'Dave'
    fill_in 'Password', with: 'cars'
    click_button 'Login'
  end

  test "admin receives request when order placed" do
    login_user
    add_car_to_cart

    visit "/cart"
    click_link "Check Out"

    login_store_admin
    admin = User.find_by(username: "Dave")

    assert_equal "/#{admin.store.slug}/dashboard/#{admin.store_id}", current_path
    assert page.has_content?("Pending Orders")
    assert page.has_content?("Matt")
    assert_equal "pending", Order.first.current_status
  end

  test "store admin can approve pending orders" do
    create_user
    create_user_order(1)
    login_store_admin

    order = Order.first
    admin = User.find_by(username: "Dave")

    assert_equal "/#{admin.store.slug}/dashboard/#{admin.store_id}", current_path
    assert page.has_content?("Pending Orders")
    assert page.has_content?("Matt")
    assert_equal "pending", order.current_status

    click_link "Approve Order"

    assert_equal "/#{admin.store.slug}/dashboard/#{admin.store_id}", current_path
    assert_equal "ordered", order.reload.current_status
  end

  test "store admin can decline pending orders" do
    create_user
    create_user_order(1)
    login_store_admin

    order = Order.first
    admin = User.find_by(username: "Dave")

    assert page.has_content?("Pending Orders")
    assert page.has_content?("Matt")
    assert_equal "pending", order.current_status

    click_link "Decline Order"

    assert_equal "/#{admin.store.slug}/dashboard/#{admin.store_id}", current_path
    assert_equal "canceled", order.reload.current_status
  end
end
