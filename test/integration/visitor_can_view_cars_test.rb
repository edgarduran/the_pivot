require 'test_helper'

class VisitorCanViewCarsTest < ActionDispatch::IntegrationTest
  test 'a user can view cars index' do
    create_cars(2)

    visit root

    within_css(".btn") do
      click_button "View Cars"
    end

    assert_equal cars_path, current_path

    within_css("h1") do
      assert page.has_content?('Cars')
    end

    within_css("li:first") do
      assert page.has_content?('Chevy0')
      assert page.has_content?('El Camino0')
      assert page.has_content?('$100')
      assert page.has_content?("Dave's Cars")
    end

    within_css("li:last") do
      assert page.has_content?('Chevy1')
      assert page.has_content?('El Camino1')
      assert page.has_content?('$101')
      assert page.has_content?("Dave's Cars")
    end
  end

  test "visitor can navigate to store page from index" do
    skip
  end

  test "visit can navigate to individual car page from index" do
    skip
  end
end
