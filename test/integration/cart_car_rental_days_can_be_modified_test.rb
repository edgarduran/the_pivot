require 'test_helper'

class CartCarRentalDaysCanBeModifiedTest < ActionDispatch::IntegrationTest
  test 'cart cars rental days can be modified' do
    add_car_to_cart
    visit cart_path

    fill_in 'Days', with: 3
    click_button 'Update'

    assert page.has_content?('3')
    assert page.has_content?('300')
  end
end
