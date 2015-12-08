require 'test_helper'

class StoreAdminCanCreateCarsTest < ActionDispatch::IntegrationTest
  test 'store admin can add cars to their store' do
    create_store_admin
    login_store_admin
    locations = Location.create(name: 'Capitol Hill')

    click_link 'Add car to store'
    fill_in 'Make', with: 'Geo'
    fill_in 'Model', with: 'Metro'
    fill_in 'Year', with: '1983'
    fill_in 'Description', with: 'Sweet ride!'
    fill_in 'Location', with: "Capitol Hill"
    fill_in 'Daily price', with: 59
    click_button 'Add Car'

    assert page.has_content?('Car 1983 Geo Metro has been added to store')
    assert page.has_content?('Geo')
  end
end
