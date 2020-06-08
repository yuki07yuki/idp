require 'test_helper'

class VisitorRegistrationTest < ActionDispatch::IntegrationTest

  def setup
    @resident = residents(:resident_1_1)
    @pass = visitor_passes(:visitor_pass_1)

  end

  test 'cannot visit a page if id and token do not match' do
    get new_visitor_path(resident_id: "1", token: @pass.token) # wrong id corrent token
    assert_equal 'Invalid Link', flash[:danger]
    assert_redirected_to root_path
    follow_redirect!
    flash_cleared?

    get new_visitor_path(resident_id: @resident.id, token: "123456") # corrent id wrong token
    assert_equal 'Invalid Link', flash[:danger]
    assert_redirected_to root_path
    follow_redirect!
    flash_cleared?


    get new_visitor_path(resident_id: @resident.id, token: "12345") # corrent id correct token
    assert_equal "ok", flash[:ok]

  end

  test 'cannot register if any field is empty' do

  end

  test 'can register without a car' do

  end

  test 'can register with car' do

  end

end
