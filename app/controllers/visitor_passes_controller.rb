class VisitorPassesController < ApplicationController


  def new
    @visitor_pass = VisitorPass.new
    @controller = "visitor_passes"
   # debugger
  end

  def create

    @resident = Resident.find_by(resident_params)
    unless @resident && correct_password?
      flash[:danger] = "Invalid resident key."
      redirect_to new_visitor_pass_path
      return
    end

    @visitor_pass = create_visitor_pass
    if @visitor_pass.save
      # send email
      # debugger
      ResidentMailer.visitor_details(@visitor_pass).deliver_now
      flash[:success] = success_message
      redirect_to root_path
    else
      flash[:danger] = failure_message
     redirect_to new_visitor_pass_path
    end

  end


  private

      def resident_params
        params.permit(:floor, :unit)
      end

      def create_visitor_pass
        # debugger
        VisitorPass.new(resident_id:    @resident.id,
                          email: params[:email],
                          token:        generate_token,
                          secret_key: params[:secret_key],
                          requested_at: Time.zone.now )
      end

      def correct_password?
        @resident.authenticate(params[:resident_key])
      end

      def generate_token
        SecureRandom.urlsafe_base64
      end

      def success_message
        msg = "The email has been sent to the visitor.\n"
        msg += "Thank you."
        msg
      end

      def failure_message
        msg = "Sorry. Something went wrong."
      end

end
