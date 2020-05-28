require 'test_helper'

class VisitorPassApplicationTest < ActionDispatch::IntegrationTest

  def setup
    @resident11 = residents(:resident_1_1)
  end

  test 'cannot apply if resident verification fails' do
    get new_visitor_pass_path
    assert_template 'visitor_pass/new'

    post new_visitor_pass_path , params: {resident_key: "" }
    assert_template 'visitor_path/new'
    assert_equal "Wrong credentials.", flash[:danger], "Wrong flash"

  end





end
