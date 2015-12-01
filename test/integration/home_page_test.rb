require "test_helper"

class HomePageTest < ActionDispatch::IntegrationTest
  test "visitor can view homepage" do
    visit "/"

    assert page.has_content?("Your Dream Car for a Day")
    assert page.has_link?("View Cars")
    assert page.has_content?("Testimonial")
    assert page.has_content?("What a great site! I needed a car in a pinch and Borrow-my-Carro delivered.")
  end
end
