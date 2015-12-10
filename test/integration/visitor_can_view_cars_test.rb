require 'test_helper'

class VisitorCanViewCarsTest < ActionDispatch::IntegrationTest
  test 'a user can view cars index' do
    create_cars(2)
    visit "/"

    click_button "Drive Your Dream"

    assert_equal cars_path, current_path

    within("h1") do
      assert page.has_content?('Cars')
    end

    assert page.has_content?('1960 El Camino0 Chevy0')
    assert page.has_content?('$100')

    assert page.has_content?('1961 El Camino1 Chevy1')
    assert page.has_content?('$101')
  end

  test "visitor can navigate to store page from index" do
    create_cars(1)
    visit cars_path

    within(".cars-index") do
      click_link "View Car"
    end
    
    click_link "Dave's Cars"

    assert_equal store_cars_path(store: Store.first.slug), current_path
  end
end
