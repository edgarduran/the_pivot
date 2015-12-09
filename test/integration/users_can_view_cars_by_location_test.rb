require 'test_helper'

class UsersCanViewCarsByLocationTest < ActionDispatch::IntegrationTest
  test 'user clicks location link and is routed to locations index' do
    create_locations
    visit "/"

    within(".nav-wrapper") do
      click_link "All"
    end

    assert_equal current_path, locations_path
    assert page.has_content?("Locations")
    assert page.has_content?("Capitol Hill")
    assert page.has_content?("Highland")
    assert page.has_content?("Five Points")
    assert page.has_content?("Lodo")
  end

  test 'user can view cars by location' do
    create_cars(4)
    visit locations_path

    within(".cars") do
      click_link "Capitol Hill"
    end

    assert_equal current_path, location_path(Location.first.slug)
    assert page.has_content?("Capitol Hill")
    assert page.has_content?("Chevy0")
    assert page.has_content?("El Camino0")
    assert page.has_content?("1960")
    assert page.has_content?("Chevy2")
    assert page.has_content?("El Camino2")
    assert page.has_content?("1962")

    visit location_path(Location.last.slug)

    assert page.has_content?("Five Points")
    assert page.has_content?("Chevy1")
    assert page.has_content?("El Camino1")
    assert page.has_content?("1961")
    assert page.has_content?("Chevy3")
    assert page.has_content?("El Camino3")
    assert page.has_content?("1963")
  end
end
