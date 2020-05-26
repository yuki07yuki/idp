class ResidentsController < ApplicationController
  include SessionsHelper
  before_action :admin

  def new
    @resident = Resident.new
  end


  def create
    @resident = Resident.new(resident_params)
    if @resident.save
      flash[:success] = "Resident succesfully registered"
      redirect_to "/residents/index"
      send_password_to_resident(@resident)
    else
      flash.now[:danger] = 'Something went wrong!'
      render 'new'
    end
  end


  def index
    @residents = Resident.all.where.not(admin:true)
                          .order(:floor).order(:unit)
  end


  def edit
    @resident = the_resident
  end


  def update
    the_resident.update(updated_params)
    flash[:success] = "Successfully updated"
    redirect_to '/residents/index'
  end


  def destroy
    the_resident.destroy
    flash[:success] = "Resident deleted"
    redirect_to '/residents/index'
  end


  private

    # all
    def the_resident
      Resident.find_by( unit: params[:unit], floor: params[:floor] )
    end

    # Create
    def resident_params
      add_password_to_params
      params
      .require(:resident)
      .permit(:floor, :unit, :name, :ic, :phone,
        :email, :password, :password_confirmation)
    end

    def add_password_to_params
      password = SecureRandom.urlsafe_base64(10)
      params[:resident][:password] = password
      params[:resident][:password_confirmation] = password
    end

    def send_password_to_resident(resident)
      message = "Your secret resident key is '#{params[:resident][:password]}'"
      TwilioClient.new.send_whatsapp(resident.phone, message)
    end

    def password
      params[:resident][:password]
    end

    # Update
    def updated_params
      params
      .require(:resident)
      .permit(:floor, :unit, :name, :ic,:phone, :email)
    end

    # check before every action
    def admin
      unless (current_user && current_user.admin?)
        flash[:danger] = "Please log in to continue"
        redirect_to '/login'
      end
    end
end
