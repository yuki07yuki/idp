require 'test_helper'

class AdminLoginTest < ActionDispatch::IntegrationTest

  test 'unsuccessful login' do
    get '/login'
    assert_template 'sessions/new'
    assert_select "a[href=?]", '/login'

    post login_path, params: { session: { username: "", password: "" } }
    assert_template 'sessions/new'
    assert_select "a[href=?]", '/login'
    assert_equal 'Invalid username or password', flash[:danger] , 'wrong flash message'

    get root_path
    assert flash.empty?

  end

  test 'succesful login' do
    get '/login'
    assert_template 'sessions/new'
    assert_select "a[href=?]", '/login'

    post login_path, params: { session: { username: "admin", password: "000000" } }
    assert_redirected_to '/residents/index'
    follow_redirect!

    assert_equal 'Successfully logged in', flash[:success], 'wrong flash message'
    assert_select "a[href=?]", '/logout'

    get root_path
    assert flash.empty?
  end

  test 'logout' do
    get '/login'
    post login_path, params: { session: { username: "admin", password: "000000" } }
    follow_redirect!
    assert_select "a[href=?]", '/logout'

    delete logout_path
    assert_redirected_to '/login'
    follow_redirect!

    assert_select "a[href=?]", '/login'
  end





end
