require 'test_helper'

class AVisitorCanViewCarsByLocationTest < ActionDispatch::IntegrationTest
  test 'a visitor can visit location page to see all items in location' do
    create_cars(3)
    first_car = Car.first
    third_car = Car.last

    visit location_path(Location.first.slug)

    assert page.has_content?('Capitol Hill')

    within('.cars') do

      assert page.has_content?("1960 El Camino0 Chevy0")
      assert page.has_content?("Dave met his wife #0 in this car.")
      assert page.has_content?("#{first_car.daily_price}")

      assert page.has_content?("1962 El Camino2 Chevy2")
      assert page.has_content?("#{third_car.description}")
      assert page.has_content?("#{third_car.daily_price}")
    end
  end
end
