require 'test_helper'

class VisitorPassApplicationTest < ActionDispatch::IntegrationTest

  def setup
    @resident11 = residents(:resident_1_1)
  end

  test 'cannot apply if resident verification fails' do
    get new_visitor_pass_path
    assert_template 'visitor_passes/new'

    post visitor_passes_path , params: {resident_key: "" }

    assert_template 'visitor_passes/new'
    assert_equal "Invalid resident key.", flash[:danger], "Wrong flash"

    flash_all_cleared?
  end

  test 'can apply if you are a resident' do
    get new_visitor_pass_path
    assert_template 'visitor_passes/new'

    post visitor_passes_path , params: {resident_key: "000000",
                                          visitors_email: "yuki07yuki@gmail.com"}
    # assert_equal "You are a resident", flash[:success], "Wrong flash"


  end



  private



end
