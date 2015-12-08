require 'test_helper'

class UserCanViewIndividualCarPageTest < ActionDispatch::IntegrationTest
  test "visit can navigate to individual car page from index" do
    create_cars(1)
    visit cars_path

    within(".card-content") do
      click_link "1960 Chevy0 El Camino0"
    end

    assert_equal store_car_path(Car.first, store: Store.first.slug), current_path
  end

  test 'user sees full details of a car on its show page' do
    create_cars(1)
    visit store_car_path(Car.first, store: Store.first.slug)

    within("h1") do
      assert page.has_content?("1960 Chevy0 El Camino0")
    end

    within("h2") do
      assert page.has_content?("For rent by Dave's Cars")
    end

    within("h3") do
      assert page.has_content?("Daily price: $100")
      assert page.has_content?("Weekly price: $600")
    end

    within("p.description") do
      assert page.has_content?("Dave met his wife #0 in this car.")
    end
  end

  test "user can access car vendor from show page" do
    create_cars(1)
    visit store_car_path(Car.first, store: Store.first.slug)

    click_link "Dave's Cars"

    assert_equal store_cars_path(store: Store.first.slug), current_path
  end
end
