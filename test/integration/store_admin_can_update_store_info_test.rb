require 'test_helper'

class StoreAdminCanUpdateStoreInfoTest < ActionDispatch::IntegrationTest
  test ' store admin can update store info' do
    login_store_admin
    click_link 'Edit Store Info'
    fill_in 'Name', with: "Dave's Amazing Cars"
    fill_in 'About', with: "Dave has the best cars know to man.
                            Once you drive on of his cars you'll
                            never want to give it back!"
    click_button "Submit Changes"

    assert page.has_content?("Dave's Amazing Cars")
  end
end
