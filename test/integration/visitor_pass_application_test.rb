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

    flash_cleared?
  end

  test 'cannot apply if any of the field is empty' do

    get new_visitor_pass_path
    assert_template 'visitor_passes/new'

    post visitor_passes_path , params: {resident_key: "000000",
                                          visitors_email: "yuki07yuki@gmail.com",
                                          visitors_name: "",
                                          secret_key: "" }
    assert_template 'visitor_passes/new'
    assert_select 'div#error_explanation'

  end

  test 'can apply if you are a resident' do
    get new_visitor_pass_path
    assert_template 'visitor_passes/new'
    before = VisitorPass.count
    post visitor_passes_path , params: {  resident_key: "000000",
                                          visitors_email: "yuki07yuki@gmail.com",
                                          visitors_name: "athiga",
                                          secret_key: "banana" }
    after = VisitorPass.count
    assert_equal before + 1 , after
    assert_template 'home_pages/home'
    assert_equal success_message, flash[:success]
    flash_cleared?
  end



  private

      def success_message
        msg = "The email has been sent to the visitor.\n"
        msg += "Thank you."
        msg
      end



end
