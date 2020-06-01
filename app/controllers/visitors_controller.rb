class VisitorsController < ApplicationController

  def new

    debugger

    unless resident? && valid_token?
      flash[:danger] = 'Invalid Link'
      redirect_to root_path
      return
    end

    # delete the visitor_pass object from the database




  end

  def create

  end



  private

      def resident?
        Resident.find_by(id: params[:resident_id])
      end

      def valid_token?

        VisitorPass.find_by(
                             token:      params[:token],
                             resident_id: params[:resident_id])
      end


end
