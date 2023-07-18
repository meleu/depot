require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get store_index_url
    assert_response :success
    assert_select 'nav a', minimum: 4
    assert_select 'main ul li', 3 # the amount of products in the fixture
    assert_select 'h2', 'Programming Ruby' # one of the products in the fixture
    assert_select 'div', /\$[,\d]+\.\d\d/
  end
end
