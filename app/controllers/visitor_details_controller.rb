class VisitorDetailsController < ApplicationController

  def edit
    # does the resident id exists
    debugger
    unless Resident.find_by(id: params[:resident_id])
      # render invalid link
      flash[:danger] = 'Invalid Link'
      render 'invalid_link'
      return
    end

    # valid token? && correct secret key?

    # delete visitor_pass from the database
  end
end
