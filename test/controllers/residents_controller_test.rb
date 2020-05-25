require 'test_helper'

class ResidentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @admin = residents(:admin)
    @r1 = residents(:resident_1_1)
  end

  test "can view register if admin" do
    login @admin
    get '/register'
    assert_response :success
  end

  test "can view residents table if admin" do
    login @admin
    get '/residents/index'
    assert_response :success
  end

  test "can view residents details if admin" do
    login @admin
    get "/residents/#{@r1.floor}/#{@r1.unit}/edit"
    assert_response :success
  end

  index = {name: 'index', link: '/residents/index'}
  new = {name: 'new', link: '/register'}
  update = {name: 'update', link: '/residents/1/2/edit'}

  [index, new, update].each do |hash|
    define_method \
    "test_cannot_view_#{hash[:name]}_if_not_logged_in" do
      get hash[:link]
      redirected_to_login
    end
  end

  test 'should redirect update request if not admin' do
    patch "/residents/#{@r1.floor}/#{@r1.unit}/edit" ,
          params: { resident: { name: "", email: ""}}
    redirected_to_login
  end

  test 'should redirect destroy if not admin' do
    assert_no_difference 'Resident.count' do
      delete "/residents/#{@r1.floor}/#{@r1.unit}"
    end
    redirected_to_login
  end

  # test 'succesful register' do
  #   login @admin
  #   get "/register"
  #   assert_template 'residents/new'
  #
  #   before_count = Resident.count
  #   create( floor: 15,
  #           unit: 15,
  #           name:  "Example User",
  #           email: "user@example.com",
  #           phone: "+5571981265131",
  #           ic: "TZ0775380",
  #           password:              "000000",
  #           password_confirmation: "000000" )
  #
  #   after_count = Resident.count
  #
  #   assert_equal before_count + 1, after_count
  #
  #   assert_redirected_to '/residents/index'
  #   follow_redirect!
  #
  #   assert_equal "Resident succesfully registered", flash[:success]
  #
  #   flash_all_cleared?
  # end

  test 'successful edit' do
    login(@admin)
    get "/residents/#{@r1.floor}/#{@r1.unit}/edit"
    assert_template 'residents/edit'

    update(@r1, name: new_name, email: new_email )

    assert_not flash.empty?
    assert_redirected_to "/residents/index"

    @r1.reload
    assert_equal new_name, @r1.name
    assert_equal new_email, @r1.email
  end


  private

      def login(user , password: nil)
        password = "000000" if password == nil
        post login_path, params: { session: { username: user.name, password: password } }
      end

      def redirected_to_login
        assert_redirected_to '/login'
        follow_redirect!
        assert_equal "Please log in to continue",flash[:danger]
      end

      def update(resident, hash)
        patch "/residents/#{resident.floor}/#{resident.unit}/edit" ,
          params: { resident: hash }
      end

      def create(hash)
        post '/register', params: { resident: hash }
      end

      def flash_all_cleared?
        get root_path
        assert flash.empty?
      end

      def new_name
        "Foo"
      end

      def new_email
        "foo@bar.com"
      end

end
