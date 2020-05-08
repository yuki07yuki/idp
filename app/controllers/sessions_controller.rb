class SessionsController < ApplicationController
  def new
  end

  def create
    if valid_password?
      flash[:success] = 'Successfully logged in'
      redirect_to '/residents/index'
    else
      flash.now[:danger] = 'Invalid username or password'
      render 'new'
    end
  end


  private

    def admin
      Resident.find_by(admin: true)
    end

    def valid_password?
      admin && admin.authenticate(params[:session][:password])
    end


end
