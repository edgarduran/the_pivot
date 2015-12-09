require 'test_helper'

class UserCanCheckOutToPlaceAnOrderTest < ActionDispatch::IntegrationTest
  test 'a visitor must log in before checking out' do
    add_car_to_cart

    visit '/cart'

    assert_equal cart_path, current_path

    click_link 'Check Out'

    assert_equal login_path, current_path
    assert page.has_content?('You must be logged in to check out')
  end

  test "an existing user can check out" do
    login_user
    add_car_to_cart

    within('.cart-count') do
      assert page.has_content?('1')
    end

    visit '/cart'
    click_link 'Check Out'

    assert_equal '/orders', current_path

    within('table') do
      assert page.has_content?('Pending')
      assert page.has_link?('View Order')
    end

    within('.cart-count') do
      assert page.has_content?('0')
    end
  end

  test 'an_existing_user_cant_check_out_with_0_cars' do
    create_user
    login_user

    visit '/cart'
    click_link 'Check Out'

    assert_equal cars_path, current_path

    assert page.has_content?("There's nothing in your cart.")
  end
end
