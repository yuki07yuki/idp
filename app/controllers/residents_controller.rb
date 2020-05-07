class ResidentsController < ApplicationController
  def new
    @resident = Resident.new
  end

  def create

    @resident = Resident.new(resident_params)

    if @resident.save
      flash[:success] = "Resident succesfully registered"
      redirect_to "/residents/index"
      send_password_to_resident
    else
      flash.now[:danger] = 'Something went wrong!'
      render 'new'
    end

  end

  def index
    @residents = Resident.all
  end

  def edit
    @resident = the_resident
  end

  def update
    the_resident.update(updated_params)
    redirect_to '/residents/index'
  end

  def destroy
    the_resident.destroy
    flash[:success] = "Resident deleted"
    redirect_to 'residents/index'
  end

  private

    # all
    def the_resident
      Resident.find_by( unit: params[:unit],floor: params[:floor] )
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
      # TODO: Change the password
      password = SecureRandom.urlsafe_base64
      params[:resident][:password] = "000000"
      params[:resident][:password_confirmation] = "000000"
    end

    def send_password_to_resident
      # TODO: Implement password sending to the new registered resident
    end

    # Update
    def updated_params
      params
      .require(:resident)
      .permit(:floor, :unit, :name, :ic,:phone, :email)
    end

end
