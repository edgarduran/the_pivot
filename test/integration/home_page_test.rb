require 'test_helper'

class HomePageTest < ActionDispatch::IntegrationTest
  test 'visitor can view homepage' do
    skip
    # do we even need to create this for it to work? commented out for now
    # create_featured_car
    visit '/'

    assert page.has_content?('Your Dream Car for a Day')
  end
end
