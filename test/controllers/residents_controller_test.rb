require 'test_helper'

class ResidentsControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get '/register'
    assert_response :success
  end

  test "should get index" do
    get '/residents/index'
    assert_response :success
  end

end
