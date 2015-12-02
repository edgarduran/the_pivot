require 'test_helper'

class VisitorCanViewProductsTest < ActionDispatch::IntegrationTest
  include CategoryItemsSetup
  test 'a user can view cars' do
    create_cars

    visit cars_path

    assert page.has_content?('Tesla')
  end
end
