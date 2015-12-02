require "test_helper"

class HomePageTest < ActionDispatch::IntegrationTest
  test "visitor can view homepage" do
    visit "/"

    assert page.has_content?('Drive Your Dream Car for a Day')
    assert page.has_link_or_button?("Drive Your Dream")
    assert page.has_content?("Torie")
    assert page.has_content?("Edgar")
    assert page.has_content?("David")
    assert page.has_content?("I love the cars they have to offer.")
    assert page.has_content?("I'm obsessed with the service that BMC has to offer.")
    assert page.has_content?("I love the car I'm borrowing from BMC so much that I don't think I'm going to return it!")
  end
end
