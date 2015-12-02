require 'test_helper'

class UserCanAddCarsToGarageTest < ActionDispatch::IntegrationTest
  test 'user can add cars to garage from index' do
    create_cars(1)
    visit cars_path

    click_link 'Add to my Garage'

    wihin('.garage_count') do
      assert page.has_content?('1')
    end
  end

  test 'visitor can view garage with selected items' do
    skip
    create_cars(1)
    visit cars_path

    click_link 'Add to my Garage'
    click_link 'go-to-garage'

    assert_equal current_path, garage_path
    assert page.has_content?('Chevy0')
    assert page.has_content?('El Camino0')
    assert page.has_content?('100')
  end
  test 'user can add item to cart from show page' do
    skip
    click_link 'View Car'
    click_link 'Add to my Garage'

    within('.garage-count') do
      assert page.has_content?('1')
    end
  end


  test 'visitor can view cart with multiple items' do
    skip
    create_cars(2)
    visit cars_path


    within("##{Car.first.id}") do
      click_link 'Add to my Garage'
    end
    within("##{Car.last.id}") do
      click_link 'Add to my Garage'
    end

    click_link 'go-to-garage'
    assert_equal current_path, garage_path
    assert page.has_content?('Chevy0')
    assert page.has_content?('El Camino0')
    assert page.has_content?('100')
    assert page.has_content?('Chevy1')
    assert page.has_content?('El Camino2')
    assert page.has_content?('100')
  end
end
