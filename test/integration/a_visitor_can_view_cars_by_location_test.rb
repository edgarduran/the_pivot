require 'test_helper'

class AVisitorCanViewCarsByLocationTest < ActionDispatch::IntegrationTest
  test 'a visitor can visit location page to see all items in location' do
    create_cars(3)
    first_car = Car.first
    third_car = Car.last

    visit category_path(Location.first.slug)

    assert page.has_content?('Capitol Hill')

    within('.cars') do
      assert page.has_content?("#{first_car.full_name}")
      assert page.has_content?("#{first_car.description}")
      assert page.has_content?("#{first_car.daily_price}")

      assert page.has_content?("#{third_car.full_name}")
      assert page.has_content?("#{third_car.description}")
      assert page.has_content?("#{third_car.daily_price}")
    end
  end
end
