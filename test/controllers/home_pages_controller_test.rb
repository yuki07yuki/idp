require 'test_helper'

class HomePagesControllerTest < ActionDispatch::IntegrationTest
  test "root path should get home" do
    get root_url
    assert_response :success
  end

end
