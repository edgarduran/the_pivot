require "test_helper"

class StoreAdminReceivesRequestWhenOrderPlacedTest < ActionDispatch::IntegrationTest
  def setup
    create_user
    create_user_order(1)
    login_store_admin
  end

  def login_store_admin
    Store.first.update(approved: true)
    User.find_by(username: "Dave").roles.create(name: 'store_admin')

    visit login_path
    fill_in 'Username', with: 'Dave'
    fill_in 'Password', with: 'cars'
    click_button 'Login'
  end

  test "store admin can approve pending orders" do
    order = Order.first
    admin = User.find_by(username: "Dave")

    assert_equal "/#{admin.store.slug}/dashboard/#{admin.store_id}", current_path
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
