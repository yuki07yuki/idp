require 'test_helper'

class VisitorPassApplicationTest < ActionDispatch::IntegrationTest

  def setup
    @resident11 = residents(:resident_1_1)
  end

  test 'cannot apply if resident verification fails' do
    get new_visitor_pass_path
    assert_template 'visitor_passes/new'

    submit_form(resident_key: "123")
    assert_template 'visitor_passes/new'
    assert_select 'div#error_explanation', {text: "Resident key is invalid"}

    flash_cleared?
  end

  test 'cannot apply if any of the field is empty' do

    get new_visitor_pass_path
    assert_template 'visitor_passes/new'

    [:visitors_name, :visitors_email, :secret_key].each do |field|
      submit_form({field => ""})
      # assert_template 'visitor_passes/new'
      assert_select 'div#error_explanation', {}, "#{field} should not be allowed empty"

      flash_cleared?
    end

  end

  test 'can apply if you are a resident' do
    get new_visitor_pass_path
    assert_template 'visitor_passes/new'
    before = VisitorPass.count
    submit_form
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


      def submit_form(resident_key: "000000", visitors_email: "yuki07yuki@gmail.com", visitors_name: "Yuki", secret_key: "banana" )
        post visitor_passes_path ,
          params: {
          resident_key: resident_key,
          visitors_email: visitors_email,
          visitors_name: visitors_name,
          secret_key: secret_key
        }
      end



end
