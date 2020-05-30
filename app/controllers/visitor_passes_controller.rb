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
      ResidentMailer.visitor_details(@visitor_pass, @resident).deliver_now
    else
      flash[:danger] = "Something went wrong."
      redirect_to new_visitor_pass_path
    end


  end


  private

      def resident_params
        params.permit(:floor, :unit)
      end

      def create_visitor_pass
        VisitorPass.new(resident_id:    @resident.id,
                          token:        generate_token,
                          requested_at: Time.zone.now )
      end

      def correct_password?
        @resident.authenticate(params[:resident_key])
      end

      def generate_token
        SecureRandom.urlsafe_base64
      end

end
