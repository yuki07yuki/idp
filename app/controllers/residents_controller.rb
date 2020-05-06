class ResidentsController < ApplicationController
  def new
    @resident = Resident.new
  end

  def index
    @residents = Resident.all
  end

  def show
  end


end
