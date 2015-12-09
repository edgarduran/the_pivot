require 'test_helper'

class PlatformAdminCanOnlyDeleteCarsTest < ActionDispatch::IntegrationTest
  test 'platform admin can only delete cars' do
    create_cars(1)
    login_platform_admin

    visit cars_path

    assert page.has_content?('Dave\'s Cars')
    assert page.has_content?(100)
    assert page.has_content?('El Camino')
    assert page.has_content?('Daily Price')

    click_link 'Delete Car'

    refute page.has_content?('Dave\'s Cars')
    refute page.has_content?(100)
    refute page.has_content?('El Camino')
  end
end
