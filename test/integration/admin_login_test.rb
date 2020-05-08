require 'test_helper'

class AdminLoginTest < ActionDispatch::IntegrationTest

  test 'unsuccessful login' do
    get '/login'
    assert_template 'sessions/new'
    post login_path, params: { session: { username: "", password: "" } }
    assert_template 'sessions/new'
    assert_equal 'Invalid username or password', flash[:danger] , 'wrong flash message'
  end

  test 'succesful login' do
    get '/login'
    assert_template 'sessions/new'
    post login_path, params: { session: { username: "admin", password: "000000" } }
    assert_redirected_to '/residents/index'
    assert_equal 'Successfully logged in', flash[:success], 'wrong flash message'
  end





end
