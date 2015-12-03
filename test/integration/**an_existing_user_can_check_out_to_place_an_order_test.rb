require 'test_helper'

class AnExistingUserCanCheckOutToPlaceAnOrderTest < ActionDispatch::IntegrationTest
  test 'a visitor must log in before checking out' do
    create_categories_and_cars
    add_items_to_cart

    visit '/cart'
    click_link 'Check Out'

    assert_equal login_path, current_path
    assert page.has_content?('You must be logged in to check out')
  end

  test "an_existing_user_can_check_out_to_place_an_order and cart returns
    to zero" do
    create_user
    login_user
    create_categories_and_cars
    add_items_to_cart

    within('.cart-count') do
      assert page.has_content?('3')
    end

    visit '/cart'
    click_link 'Check Out'

    assert_equal '/orders', current_path

    within('table') do
      assert page.has_content?('ordered')
      assert page.has_content?('View Order')
    end

    within('.cart-count') do
      assert page.has_content?('0')
    end
  end

  test 'an_existing_user_cant_check_out_with_0_items' do
    create_user
    login_user

    visit '/cart'
    click_link 'Check Out'

    assert_equal items_path, current_path

    assert page.has_content?("There's nothing in your cart.")
  end
end
