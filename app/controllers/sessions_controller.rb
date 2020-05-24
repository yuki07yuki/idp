class SessionsController < ApplicationController
  include SessionsHelper

  def new
    if logged_in?
      redirect_to '/residents/index'
    end
  end

  def create
    if are_you_admin? && with_correct_password?
      login admin
      flash[:success] = 'Successfully logged in'
      redirect_to '/residents/index'
    else
      flash.now[:danger] = 'Invalid username or password'
      render 'new'
    end
  end

  def destroy
    logout
    flash[:success] = 'Successfully logged out'
    redirect_to '/login'
  end


  private

    def admin
      Resident.find_by(admin: true)
    end

    def admin?
      current_user.admin?
    end

    def valid_password?
      admin && admin.authenticate(params[:session][:password])
    end

    def are_you_admin?
      trying_to_login_user && trying_to_login_user.admin?
    end

    def trying_to_login_user
      Resident.find_by(name: params[:session][:username])
    end

    def with_correct_password?
      trying_to_login_user.authenticate(params[:session][:password])
    end

end
