require 'test_helper'

class VisitorCanViewProductsTest < ActionDispatch::IntegrationTest
  test 'a user can view items' do
    create_items

    visit items_path

    assert page.has_content?('Snowboards')
    assert page.has_content?('GNAR POSSUM')
    assert page.has_content?('GWAR POSSUM')
  end
end
