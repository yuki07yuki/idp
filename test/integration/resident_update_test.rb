require 'test_helper'

class ResidentUpdateTest < ActionDispatch::IntegrationTest

  def setup
    @admin = residents(:admin)
    @non_admin = residents(:non_admin)
    @yuki = residents(:yuki)
  end

  test 'cannot visit update page if not admin' do

    get '/residents/1/1/edit'
    assert_redirected_to '/login'
    assert_equal 'Please log in to continue', flash[:danger]

    login_as @non_admin
    get '/residents/1/1/edit'
    assert_redirected_to '/login'
    assert_equal 'Please log in to continue', flash[:danger]

  end

  test 'cannot update if any of the field is empty' do
    login_as @admin

    get '/residents/1/1/edit'
    assert_template 'residents/edit'

    [:name, :ic, :phone, :email].each do |field|
      submit_form({field => ""})
      field = change_case_for_output(field)
      assert_select 'ul', {text: "#{field} can't be blank"}, "#{field} is being allowed empty"
    end

  end

  test 'can update if everything is ok' do
    login_as @admin

    get '/residents/1/1/edit'
    assert_template 'residents/edit'

    submit_form(name: new_name, phone: new_phone)
    assert_redirected_to '/residents/index'
    follow_redirect!

    assert_equal 'Successfully updated', flash[:success]

    updated_user = Resident.find_by(floor: '1', unit: '1')
    updated_user.reload
    assert_equal new_name, updated_user.name
    assert_equal new_phone, updated_user.phone

    flash_cleared?

  end

  private

    def submit_form( name: 'Yuki', ic:"TZ0775380",
                      phone: "0107939912", email: "yuki07yuki@gmail.com" )
      patch '/residents/1/1/edit',
            params: {resident: { name: name, ic: ic,
                                  phone: phone, email: email }}
    end


    private

        def change_case_for_output(field)
          result = ""
          if field == :ic
            result = field.to_s.upcase
          else
            result = field.to_s.capitalize
          end
        end

        def new_name
          "Yuki Yoshimine"
        end

        def new_phone
          "+60123456789"
        end

end
