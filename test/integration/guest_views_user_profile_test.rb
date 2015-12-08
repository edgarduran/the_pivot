require "test_helper"

class GuestViewsUserProfileTest < ActionDispatch::IntegrationTest
  test "guest can see store owner's profile" do
    create_cars(1)
    create_user

    store = Store.last
    store.users << User.first

    visit cars_path
    click_link "Dave's Cars"

    assert_equal store_cars_path(store: Store.first.slug), current_path
    click_link store.owner.username

    assert_equal "/profile/#{store.owner.id}", current_path
    assert page.has_content?(store.owner.username)
  end

  test "store owner can view users' profiles" do
    skip
    # As a store owner,
    # when I click on a user,
    # I expect to see their public profile.
    # then I expect to see the owners profile/description/available cars
  end
end
