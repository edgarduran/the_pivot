require "test_helper"

class BusinessCreationTest < ActionDispatch::IntegrationTest
  # As a logged in platform admin,
  # When I view my dashboard,
  # Then I should be able to approve or decline a store creation request.
  test "registered user can request business approval" do
    skip
    login_user
    original_store_count = Store.count

    assert page.has_content?("Lend a Car")
    assert_equal new_store_path, current_path
    assert page.has_content?("Before you can lend a car, you must be approved. Apply here.")

    fill_in "Name", with: "Matt's Cars"
    click_button "Submit"

    assert_equal user_path(User.first), current_path
    assert page.has_content?("Your request to create 'Matt's Cars' has been received")

    assert_equal 1, Store.count - original_store_count
    refute Store.last.approved?
  end

  test "platform admin can approve a business" do
    skip
  end

  test "platform admin can decline a business" do
    skip
  end
end
