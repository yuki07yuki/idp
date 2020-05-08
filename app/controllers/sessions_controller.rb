class SessionsController < ApplicationController
  include SessionsHelper

  def new
    if logged_in?
      redirect_to '/residents/index'
    end
  end

  def create
    if valid_password?
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

    def valid_password?
      admin && admin.authenticate(params[:session][:password])
    end

end
