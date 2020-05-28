class VisitorPassesController < ApplicationController

  def new
    @visitor_pass = VisitorPass.new
  end

  def create
    debugger

    unless resident? && correct_password?
      flash.now[:danger] = "Wrong credentials"
      render new_visitor_pass_path
      return
    end




  end


  private

      def resident_params
        params.permit(:floor, :unit,
                      :resident_key,
                      :visitor_name,
                      :phone,
                      :secret_key)
      end

      def resident?
        @resident = Resident.find_by(floor: params[:floor],
                          unit: params[:unit])
        @resident
      end

      def correct_password?
        resident?.authenticate(params[:resident_key])
      end
end
