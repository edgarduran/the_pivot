require "test_helper"

class CannotViewAnotherUsersOrderTest < ActionDispatch::IntegrationTest
  def setup
    create_user
    create_user_order
  end

  test "a registered user cannot view another users orders" do
    create_and_login_additional_user

    visit "/orders"

    refute page.has_content?("#{Car.first.full_name}")
  end

  test "a non-registered user cannot view another users orders" do
    visit "/orders"

    refute page.has_content?("#{Car.first.full_name}")
  end
end
