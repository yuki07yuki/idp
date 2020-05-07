class ResidentsController < ApplicationController
  def new
    @resident = Resident.new
  end

  def create
    redirect_to '/residents/index'
  end

  def index
    @residents = Resident.all
  end

  def edit
    @resident = Resident.find_by( unit: params[:unit],
                                  floor: params[:floor] )
  end

  def update
    redirect_to '/residents/index'
  end

end
