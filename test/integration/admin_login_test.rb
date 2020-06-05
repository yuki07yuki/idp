require 'test_helper'

class AdminLoginTest < ActionDispatch::IntegrationTest

  def setup
    @admin = residents :admin
    @non_admin = residents :non_admin
  end

  test 'failed login with wrong info' do
    get '/login'
    correct_login_page?

    login(@admin, password:"")
    failed_login

    flash__cleared?

  end

  test 'failed login with corrent info but non_admin' do
    get '/login'
    correct_login_page?

    login(@non_admin)
    failed_login

    flash__cleared?

  end


  test 'succesful login with admin' do
    get '/login'
    correct_login_page?

    login @admin
    succesful_login

    flash__cleared?
  end

  test 'logout' do
    get '/login'
    correct_login_page?

    login @admin
    succesful_login

    logout
    succesful_logout

    flash__cleared?

  end



  private


      def login(user , password: nil)
        password = "000000" if password == nil
        post login_path, params: { session: { username: user.name, password: password } }
      end

      def logout
        delete logout_path
      end

      def correct_login_page?
        assert_template 'sessions/new'
        assert_select "a[href=?]", '/login'
      end


      def failed_login
        assert_template 'sessions/new'
        assert_select "a[href=?]", '/login'
        assert_equal 'Invalid username or password',
                      flash[:danger] , 'wrong flash message'
      end

      def succesful_login
        assert_redirected_to '/residents/index'
        follow_redirect!

        assert_equal 'Successfully logged in', flash[:success], 'wrong flash message'
        assert_select "a[href=?]", '/logout'
      end

      def succesful_logout
        assert_redirected_to '/login'
        follow_redirect!
        assert_select "a[href=?]", '/login'
      end

      def flash__cleared?
        get root_path
        assert flash.empty?
      end


end
