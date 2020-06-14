class VisitorsController < ApplicationController

  def new
    debugger
    if resident && visitor_pass && !visitor_pass.expired?
      @visitor = Visitor.new
      @visitor_pass = visitor_pass
      @resident = resident
    else
      flash.now[:danger] = 'Invalid Link'
      render "home_pages/home"
    end
  end

  def create
    @visitor = Visitor.new(visitor_params)
    @visitor_pass = VisitorPass.find_by(id: params['visitor_pass_id'])
    @resident = Resident.find_by(id: params['resident_id'])
    # debugger

    # verify the secret key submitted by the visitor
    # debugger

    if correct_secret_key? && @visitor.save

      flash.now[:success] = "The QR code has been sent to your email"

      qrcode_client = QrcodeClient.new
      qrcode_client.generate2(resident: @resident, visitor: @visitor, path: path)
      ResidentMailer.qrcode(@visitor, path).deliver_now

      # delete the visitor pass and qr code
      # visitor_pass.delete

      render 'home_pages/home'
    else
      unless correct_secret_key?
        # @visitor.errors[:secret_key] = ""
        @visitor.errors.delete :secret_key
        @visitor.errors.add(:secret_key, "Please ask the resident for the correct secret key")
      end
      # debugger
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

      def path
        "#{Rails.root}/app/assets/images/qrcode#{visitor_pass.id}.png"
      end

      def correct_secret_key?
        @visitor.secret_key == @visitor_pass.secret_key
      end
end
