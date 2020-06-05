class ResidentsController < ApplicationController
  include SessionsHelper
  before_action :admin

  def new
    @resident = Resident.new
  end


  def create
    @resident = Resident.new(resident_params)
    password = generate_password
    @resident.update(password: password,
                      password_confirmation: password)
    if @resident.save
      flash[:success] = "Resident successfully registered"
      redirect_to "/residents/index"
      ResidentMailer.registration_email(@resident, password).deliver_now
    else
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
    @resident = the_resident
    if @resident.update(updated_params)
      flash[:success] = "Successfully updated"
      redirect_to '/residents/index'
    else
      # debugger
      render 'edit'
    end
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
    def resident_params2
      add_password_to_params
      params
      .require(:resident)
      .permit(:floor, :unit, :name, :ic, :phone,
        :email, :password, :password_confirmation)
    end

    def resident_params
      params
      .require(:resident)
      .permit(:floor, :unit, :name, :ic, :phone,:email)
    end

    def add_password_to_params
      password = SecureRandom.urlsafe_base64(10)
      params[:resident][:password] = password
      params[:resident][:password_confirmation] = password
    end

    def generate_password
      SecureRandom.urlsafe_base64(10)
    end

    def whatsapp_password_to_resident(resident)
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

    def updated_params2
      params.require(:resident).permit(:name, :ic, :phone, :email)
    end

    # check before every action
    def admin
      unless (current_user && current_user.admin?)
        flash[:danger] = "Please log in to continue"
        redirect_to '/login'
      end
    end
end
