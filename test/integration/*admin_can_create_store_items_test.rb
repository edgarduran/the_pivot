require 'test_helper'

class AdminCanCreateStoreItemsTest < ActionDispatch::IntegrationTest
  test 'admin can modify their account data' do
    @category = Category.create(title: 'Apparel')
    admin = User.create(username: 'admin',
                        password: 'password',
                        role:      1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    visit admin_dashboard_index_path(admin)
    click_link 'Add items to store'
    fill_in 'Name', with: 'NewGear'
    fill_in 'Brand', with: 'AwesomeBrand'
    fill_in 'Description', with: 'Put this thing on!'
    fill_in 'Category', with: @category.id
    fill_in 'Price', with: '777'
    click_button 'Create Item'
    assert page.has_content?('Item NewGear has been added to store')
    assert page.has_content?('NEWGEAR')
    assert page.has_content?('777')
  end
end
