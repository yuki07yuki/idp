class VisitorsController < ApplicationController

  def new
    if resident && visitor_pass
      @visitor = Visitor.new
    else
      flash.now[:danger] = 'Invalid Link'
      render "home_pages/home"
    end
  end

  def create
    @visitor = Visitor.new(visitor_params)

    # debugger

    if @visitor.save

      # delete visitor pass
      visitor_pass.delete
      flash.now[:success] = "The QR code has been sent to your email"

      # Create a QR code and send to the visitor

      render 'home_pages/home'
    else
      render 'new'
    end




  end



  private

      def resident
        Resident.find_by(id: params[:resident_id])
      end

      def visitor_pass
        VisitorPass.find_by( visitor_pass_params )
      end

      def visitor_pass_params
        params.permit(:token, :resident_id)
      end

      def visitor_params
        params.require(:visitor)
              .permit(:name,
                  :ic,
                  :phone,
                  :email,
                  :car,
                  :secret_key)
      end

end
