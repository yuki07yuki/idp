require 'test_helper'

class ResidentRegistrationTest < ActionDispatch::IntegrationTest

  def setup
    @admin = residents(:admin)
  end

  test 'cannot visit the registeration if not logged in as admin' do
    get '/register'
    assert_redirected_to '/login'
    follow_redirect!

    assert_equal "Please log in to continue", flash[:danger]

    flash_cleared?
  end

  test 'cannot register if any of the field is empty' do
    login_as @admin
    rendered_correct_register_page?

    any_empty_field_allowed?

    flash_cleared?
  end

  test 'cannot register if there already an exisiting resident in the unit' do
    login_as @admin
    rendered_correct_register_page?

    duplicate_resident_allowed?

    assert_template 'residents/new'
    assert_select 'ul', text: "Resident has already been registered in the unit"
  end

  test 'can register if everything is fine' do
    login_as @admin
    rendered_correct_register_page?

    successfully_registered?

    assert_equal 1, ActionMailer::Base.deliveries.size

    flash_cleared?
  end

  private

    def submit_registration(floor: '20', unit: '1',
                            name: 'Yuki', ic:"TZ0775380",
                            phone: "0107939912",
                            email: "yuki07yuki@gmail.com",
                            password: "000000",
                            password_confirmation: "000000" )
      post register_path,
            params: {resident: { floor: floor, unit: unit,
                                  name: name,
                                  ic: ic,
                                  phone: phone,
                                  email: email,
                                  password: password ,
                                  password_confirmation: password_confirmation }}
    end

    def change_case_for_output(field)
      field == :ic ? field.to_s.upcase : field.to_s.capitalize
    end

    def rendered_correct_register_page?
      get '/register'
      assert_template 'residents/new'
    end

    def any_empty_field_allowed?
      before = Resident.count
      [:name, :ic, :phone, :email].each do |field|
        submit_registration({field => ''})
        after = Resident.count
        assert_equal before, after, "#{field} should not be allowed empty"

        field = change_case_for_output(field)
        assert_select 'ul', text: "#{field} can't be blank"
      end
    end

    def duplicate_resident_allowed?
      before = Resident.count
      submit_registration(floor: '1')
      after = Resident.count
      assert_equal before, after
    end

    def successfully_registered?
      before = Resident.count
      submit_registration
      after = Resident.count
      assert_equal before + 1, after

      assert_redirected_to residents_index_path
      follow_redirect!
      assert_equal 'Resident successfully registered.', flash[:success]
    end

end
