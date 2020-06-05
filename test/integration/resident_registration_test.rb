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
  end

  test 'cannot register if any of the field is empty' do
    login_as @admin
    get '/register'
    assert_template 'residents/new'
    before = Resident.count

    [:name, :ic, :phone, :email].each do |field|
      submit_registration({field => ''})
      after = Resident.count
      assert_equal before, after, "#{field} should not be allowed empty"
      
      field = change_field_for_output(field)
      assert_select 'div#error_explanation', text: "#{field} can't be blank"
    end

  end

  test 'cannot register if there already an exisiting resident in the unit' do
    login_as @admin
    get '/register'
    assert_template 'residents/new'
    before = Resident.count
    submit_registration(floor: '1')
    after = Resident.count
    assert_equal before, after

    assert_template 'residents/new'
    assert_select 'div#error_explanation', text: "Only one resident can be registered per unit"
  end

  test 'can register if everything is fine' do
    login_as @admin
    get '/register'
    assert_template 'residents/new'
    before = Resident.count
    submit_registration
    after = Resident.count
    assert_equal before + 1, after

    assert_redirected_to residents_index_path
    follow_redirect!
    assert_equal 'Resident successfully registered', flash[:success]

    flash__cleared?

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

    def change_field_for_output(field)
      result = ""
      if field == :ic
        result = field.to_s.upcase
      else
        result = field.to_s.capitalize
      end
    end

end
