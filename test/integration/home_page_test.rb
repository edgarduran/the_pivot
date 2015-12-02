require 'test_helper'

class HomePageTest < ActionDispatch::IntegrationTest
  include CategoryItemsSetup
  test 'visitor lands on homepage with slider' do
    create_featured_item
    visit '/'

    assert page.has_content?('Drive Your Dream Car for a Day')
  end
end
