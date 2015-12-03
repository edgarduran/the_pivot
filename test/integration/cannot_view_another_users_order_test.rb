require "test_helper"

class CannotViewAnotherUsersOrderTest < ActionDispatch::IntegrationTest
  test "a registered user cannot view another users orders" do
    create_user_order
    create_and_login_additional_user

    visit "/orders"

    refute page.has_content?("other users ordeer")
  end

  test "a non-registered user cannot view another users orders" do
    skip
  end
end
