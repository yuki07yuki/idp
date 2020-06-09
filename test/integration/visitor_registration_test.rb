require 'test_helper'

class VisitorRegistrationTest < ActionDispatch::IntegrationTest

  def setup
    @resident = residents(:resident_1_1)
    @pass = visitor_passes(:visitor_pass_1)

  end

  test 'visitor cannot visit a page if id and token do not match' do
    get new_visitor_path(resident_id: wrong_id , token: @pass.token) # wrong id corrent token
    assert_equal 'Invalid Link', flash[:danger]
    assert_template 'home_pages/home'
    flash_cleared?

    get new_visitor_path(resident_id: @resident.id, token: wrong_token ) # corrent id wrong token
    assert_equal 'Invalid Link', flash[:danger]
    assert_template 'home_pages/home'
    flash_cleared?

  end

  test 'visitor cannot register if any field is empty' do
    get new_visitor_path(resident_id: @resident.id, token: @pass.token )

    before = Visitor.count
    [:name, :ic, :phone, :email, :secret_key].each do |field|
      submit_form( {field => ""} )
      field = change_case field
      assert_select 'ul',
        {text: "#{field} can't be blank"},
        "incorrect error msg for #{field}"
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

  test 'visitor pass should be deleted after visitor registration' do
    before = VisitorPass.count
    submit_form
    after = VisitorPass.count

    assert_equal before - 1, after, "Visitor Pass was not deleted"

    get new_visitor_path( resident_id: @resident.id, token: @pass.token )
    assert_template 'home_pages/home'
    assert_equal "Invalid Link", flash[:danger], "Wrong flash message"
    flash_cleared?
  end


  private

      def submit_form(
        name: "Athiga",      ic: "AB12345",
        phone: "0123456789", email: "idp@example.com",
        car: "12345",        secret_key: "banana" )

        post visitors_path,
          params: { visitor: {  name: name,
                                ic:   ic,
                                phone: phone,
                                email: email,
                                car: car,
                                secret_key: secret_key }}
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
end
