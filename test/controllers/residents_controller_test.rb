require 'test_helper'

class ResidentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @admin = residents(:admin)
  end

  test "should get new" do
    login_as @admin
    get '/register'
    assert_response :success
  end

  test "should get index" do
    login_as @admin
    get '/residents/index'
    assert_response :success
  end

  index = {name: 'index', link: '/residents/index'}
  new = {name: 'new', link: '/register'}
  update = {name: 'update', link: '/residents/1/2/edit'}

  [index, new, update].each do |hash|
    define_method "test_#{hash[:name]}_page_should_redirect_to_login_if_not_logged_in" do
      get hash[:link]
      assert_redirected_to '/login'
      follow_redirect!
      assert_equal "Please log in to continue",flash[:danger]
    end
  end
  
  # test 'index page should redirect to login if not logged in' do
  #   get '/residents/index'
  #   assert_redirected_to '/login'
  #   follow_redirect!
  #   assert "Please log in to continue",flash[:danger]
  # end
  #
  # test 'new page should redirect to login if not logged in' do
  #   get '/register'
  #   assert_redirected_to '/login'
  #   follow_redirect!
  #   assert "Please log in to continue",flash[:danger]
  # end
  #
  # test 'update page should redirect to login if not logged in' do
  #   get '/residents/1/2/edit'
  #   assert_redirected_to '/login'
  #   follow_redirect!
  #   assert "Please log in to continue",flash[:danger]
  # end

end
