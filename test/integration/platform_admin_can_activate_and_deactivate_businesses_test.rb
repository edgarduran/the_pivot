require "test_helper"

class PlatformAdminCanActivateAndDeactivateBusinessesTest < ActionDispatch::IntegrationTest
  test "platform admin can deactivate a store" do
    create_store_admin
    login_platform_admin
    previous_activated_store_count = Store.where("activated = true").count

    visit stores_path
    assert_equal stores_path, current_path

    within("div.activate-link") do
      refute page.has_content?("Activate")
    end

    click_link "Deactivate"

    assert_equal stores_path, current_path
    assert_equal 1, previous_activated_store_count - Store.where("activated = true").count
    
    within("div.activate-link") do
      assert page.has_content?("Activate")
    end
  end

  test "platform admin can activate a deactivated store" do
    skip
  end

  test "store admin cannot activate/deactivate stores" do
    skip
  end
end
