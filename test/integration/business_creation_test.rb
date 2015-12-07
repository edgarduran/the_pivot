require "test_helper"

class BusinessCreationTest < ActionDispatch::IntegrationTest
  test "registered user can request business approval" do
    login_user
    original_store_count = Store.count

    click_link "Lend a Car"
    assert_equal new_store_path, current_path
    assert page.has_content?("Before you can lend a car, you must be approved. Apply here.")

    fill_in "Name", with: "Matt's Cars"
    click_button "Request business approval"

    assert_equal user_path(User.first), current_path
    assert page.has_content?("Your request to create 'Matt's Cars' has been received")

    assert_equal 1, Store.count - original_store_count
    refute Store.last.approved?
  end

  test "user must give store name when requesting business approval" do
    login_user

    click_link "Lend a Car"
    click_button "Request business approval"

    assert_equal new_store_path, current_path
    assert page.has_content?("Try again.")
  end

  test "platform admin can approve a business" do
    create_business_approval_request
    login_platform_admin

    click_link "View pending business requests"
    assert_equal stores_path, current_path

    click_link "Approve"

    assert_equal stores_path, current_path
    assert Store.last.approved?
  end

  test "platform admin can decline a business" do
    original_store_count = Store.count

    create_business_approval_request
    login_platform_admin

    click_link "View pending business requests"
    assert_equal stores_path, current_path

    click_link "Decline"

    assert_equal stores_path, current_path
    assert_equal 0, Store.count - original_store_count
  end
end
