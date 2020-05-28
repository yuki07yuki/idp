class VisitorPassesController < ApplicationController

  def new
  end

  def create
    debugger

    unless resident? && correct_password?
      # render 'new_visitor_pass_path'
      # return
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
        Resident.find_by(floor: params[:floor],
                          unit:, params[:unit])

      end

      def correct_password?
        resident?.authenticate(params[:resident_key])
      end
end
