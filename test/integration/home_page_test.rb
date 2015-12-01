require "test_helper"

class HomePageTest < ActionDispatch::IntegrationTest
  test "visitor can view homepage" do
    create_featured_car
    visit "/"

    assert page.has_content?("Your Dream Car for a Day")
    assert page.has_content?("Today's Hottest Wheels!")
    assert page.has_content?("Details")
    assert page.has_content?("The El Camino from Dave's Cars")
    assert page.has_link?("Rent This Car")
  end
end
