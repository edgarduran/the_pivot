require "test_helper"

class GuestViewsUserProfileTest < ActionDispatch::IntegrationTest
  def login_store_admin
    Store.first.update(approved: true)
    User.find_by(username: "Dave").roles.create(name: 'store_admin')

    visit login_path
    fill_in 'Username', with: 'Dave'
    fill_in 'Password', with: 'cars'
    click_button 'Login'
  end

  test "guest can see store owner's profile" do
    create_cars(1)

    store = Store.last

    visit cars_path
    click_link "Dave's Cars"

    assert_equal store_cars_path(store: Store.first.slug), current_path
    click_link store.owner.username

    assert_equal "/profile/#{store.owner.id}", current_path
    assert page.has_content?(store.owner.username)
    assert page.has_content?("Available Cars")
    assert page.has_content?("1960 Chevy0 El Camino0")
  end

  test "store owner can view users' profiles" do
    skip
    create_user
    create_user_order(1)
    login_store_admin
    user = User.find_by(username: "Matt")

    click_link "Matt"

    assert_equal "/profile/#{user.id}", current_path
    assert page.has_content?("Order History")
    assert page.has_content?("Car Ordered")
    assert page.has_content?("Ordered From")
    assert page.has_content?("Status")

    assert page.has_content?("1960 Chevy0 El Camino0")
    assert page.has_link?("Dave's Cars")
    assert page.has_content?("Pending")
  end
end
