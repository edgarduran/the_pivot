require 'test_helper'

class VisitorCanViewDailyDealTest < ActionDispatch::IntegrationTest
  test 'a visitor can view daily deal item on homepage' do
    skip
    create_featured_car
    visit '/'

    assert page.has_content?("Today's Gnarliest Item!")
    assert page.has_content?('GNAR POSSUM')
    assert page.has_content?('$1000')
  end
end
