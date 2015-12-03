require 'test_helper'

class ACarCanBeRemovedFromCartTest < ActionDispatch::IntegrationTest
  test 'car can be removed from cart and is redirected to cart path' do
    add_car_to_cart
    visit cart_path

    assert page.has_content?("#{Car.first.full_name.upcase}")

    click_link "Remove Car"

    refute page.has_content?("#{Car.first.full_name.upcase}")
    assert_equal current_path, cart_path
  end

  test 'a green notice appears after removing a car' do
    add_car_to_cart
    visit cart_path

    click_link 'Remove Car'

    within('.flash_remove') do
      assert page.has_content?("You have removed the car: #{Car.first.full_name} from your cart.")
    end
  end

  test "car is removed if negative integer is entered in update field" do
    add_car_to_cart
    visit cart_path

    fill_in 'Days', with: -1
    click_button 'Update'

    refute page.has_content?("#{Car.first.full_name.upcase}")
  end

  test "car is removed if non-integer is entered in update field" do
    add_car_to_cart
    visit cart_path

    fill_in 'Days', with: "edddggggarrrrrr"
    click_button 'Update'

    refute page.has_content?("#{Car.first.full_name.upcase}")
  end
end
