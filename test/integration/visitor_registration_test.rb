require 'test_helper'

class VisitorRegistrationTest < ActionDispatch::IntegrationTest

  def setup
    @resident = residents(:resident_1_1)
    @visitor_pass = visitor_passes(:visitor_pass_1)
    @old_pass = visitor_passes(:old_pass)
  end

  test 'visitor cannot visit a page if id and token do not match' do
    get new_visitor_path(resident_id: wrong_id , token: @visitor_pass.token) # wrong id corrent token
    assert_equal 'Invalid Link', flash[:danger]
    assert_template 'home_pages/home'
    flash_cleared?

    get new_visitor_path(resident_id: @resident.id, token: wrong_token ) # corrent id wrong token
    assert_equal 'Invalid Link', flash[:danger]
    assert_template 'home_pages/home'
    flash_cleared?

  end

  test 'visitor cannot visit the page if the visitor pass expires' do
    puts @old_pass.attributes
    get new_visitor_path(resident_id: @resident.id, token: @old_pass.token )
    assert_equal 'Invalid Link', flash[:danger]
    assert_template 'home_pages/home'
    flash_cleared?
  end

  test 'visitor cannot visit the page if the visitor pass has already been issued' do

  end

  test 'visitor cannot register if the secret key is wrong' do
    before = Visitor.count
    submit_form(secret_key: wrong_secret_key)
    after = Visitor.count
    assert_equal before, after
    assert_select 'ul', text: "Please ask the resident for the correct secret key"
  end

  test 'visitor cannot register if any field is empty' do
    get new_visitor_path(resident_id: @resident.id, token: @visitor_pass.token )

    before = Visitor.count
    [:name, :ic, :phone, :email, :secret_key].each do |field|
      submit_form( field => "" )
      if field == :secret_key
        assert_select 'ul', text: "Please ask the resident for the correct secret key"
      else
        field = change_case field
        assert_select 'ul', text: "#{field} can't be blank"
      end
      after = Visitor.count
      assert_equal before, after, "Empty #{field} was allowed"
    end


  end

  test 'visitor can register without a car' do
    before = Visitor.count
    submit_form(car: "")
    after = Visitor.count

    assert_equal before + 1, after, "Visitor could not register without a car"

    assert_equal 'The QR code has been sent to your email', flash[:success]
    assert_template  'home_pages/home'

    flash_cleared?
  end

  test 'visitor can register with a car' do
    before = Visitor.count
    submit_form
    after = Visitor.count

    assert_equal before + 1, after, "Visitor could not register"

    assert_equal 'The QR code has been sent to your email', flash[:success]
    assert_template  'home_pages/home'

    flash_cleared?
  end

  test 'visitor pass should be void after successful submission' do
    submit_form
    visitor_pass = assigns(:visitor_pass)
    assert_equal false, visitor_pass.active?

    get new_visitor_path(resident_id: @resident.id , token: @visitor_pass.token)
    assert_equal 'Invalid Link', flash[:danger]
    assert_template 'home_pages/home'
    flash_cleared?
  end

  test 'QR code should be sent to the visitor after the registration' do
    qr = QrcodeClient.new

  end


  private

      def submit_form(resident_id = @resident.id , visitor_pass_id = @visitor_pass.id, **visitor_params)

        new_params = default_visitor_params
        visitor_params.each do |key,value|
          new_params[key] = value
        end

        post visitors_path, params: { resident_id: resident_id,
                                      visitor_pass_id: visitor_pass_id,
                                      visitor: new_params }
      end

      def default_visitor_params
        { name: "Visitor 1",      ic: "AB12345",
          phone: "0123456789", email: "idp@example.com",
          car: "12345",        secret_key: "banana" }

      end

      def change_case(field)
        return "Secret key" if field == :secret_key
        field == :ic ? field.to_s.upcase : field.to_s.capitalize
      end

      def wrong_id
        "1"
      end

      def wrong_token
        "123456789"
      end

      def wrong_secret_key
        "apple"
      end
end
