class VisitorDetailsController < ApplicationController

  def new
    debugger
    unless valid_token?
      flash[:danger] = 'Invalid Link'
      redirect_to root_path
      return
    end
    debugger
      # delete the visitor_pass object from the database

  end

  def create

  end

  def edit
    # does the resident id exists
    unless Resident.find_by(id: params[:resident_id])
      flash[:danger] = 'Invalid Link'
      redirect_to root_path
      return
    end

    # valid token?
    debugger
    if valid_token?
      # delete the visitor_pass object from the database

    else
      flash[:danger] = "Invalid link."
      redirect_to root_path
    end
    # delete visitor_pass from the database
  end

  private

      def valid_token?
        Resident.find_by(id: params[:resident_id]) &&
        VisitorPass.find_by(resident_id: params[:resident_id],
                             token:      params[:id])

      end


end
