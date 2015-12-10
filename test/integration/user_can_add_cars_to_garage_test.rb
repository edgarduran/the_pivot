require "test_helper"

class UserCanAddCarsToGarageTest < ActionDispatch::IntegrationTest
  test "user can add cars to garage from index" do
    create_cars(1)
    visit cars_path

    click_link "Add to my Garage"

    within(".cart-count") do
      assert page.has_content?("1")
    end
  end

  test "visitor can view garage with selected items" do
    add_car_to_cart

    click_link "go-to-cart"

    assert_equal current_path, cart_path
    assert page.has_content?("1960 CHEVY0 EL CAMINO0")
    assert page.has_content?("100")
  end

  test "user can visit car show page from index" do
    create_cars(1)
    car = Car.first
    visit cars_path

    within(".card-content") do
      assert page.has_content? "1960 El Camino"
      assert page.has_content? "Chevy"
    end

    click_link "View Car"

    assert_equal store_car_path(car, store:Store.first.slug), current_path
  end

  test "user can add item to cart from show page" do
    create_cars(1)
    visit store_car_path(Car.first, store:Store.first.slug)

    click_button "Drive"

    within(".cart-count") do
      assert page.has_content?("1")
    end
  end

  test "visitor can view cart with multiple items" do
    create_cars(2)
    visit cars_path

    within("##{Car.first.id}") do
      click_link "Add to my Garage"
    end

    within("##{Car.last.id}") do
      click_link "Add to my Garage"
    end

    click_link "go-to-cart"
    assert_equal current_path, cart_path
    assert page.has_content?("1960 CHEVY0 EL CAMINO0")
    assert page.has_content?("100")
    assert page.has_content?("1961 CHEVY1 EL CAMINO1")
    assert page.has_content?("101")
  end
end
