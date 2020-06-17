class VisitorPassesController < ApplicationController


  def new
    @visitor_pass = VisitorPass.new

    # this is needed for the link in the header
    @controller = "visitor_passes"
  end

  def create

    @visitor_pass = create_visitor_pass

    if invalid_resident_key?
      @visitor_pass.errors.slice!
      @visitor_pass.errors.add(:base, "Resident key is invalid")
      render 'new'
      return
    end

    if @visitor_pass.save
      # send email
      ResidentMailer.visitor_details(@visitor_pass).deliver_now
      flash.now[:success] = success_message
      render 'home_pages/home'
    else
      render 'new'
    end



    # unless @visitor_pass.save
    #   unless resident && correct_resident_key?
    #     @visitor_pass.errors.slice!
    #     @visitor_pass.errors.add(:base, "Resident key is invalid.")
    #   end
    #   render 'new'
    # else
    #   # send email
    #   # ResidentMailer.visitor_details(@visitor_pass).deliver_now
    #   flash.now[:success] = success_message
    #   render 'home_pages/home'
    # end


  end


  private

      def resident_params
        params.permit(:floor, :unit)
      end

      def resident
        Resident.find_by(resident_params)
      end

      def visitor_pass_params
        params.permit(  :visitors_name,
                        :visitors_email,
                        :secret_key )
      end

      def create_visitor_pass
        vs = VisitorPass.new(visitor_pass_params)
        vs.update(resident_id:      resident.id,
                    token:          generate_token,
                    created_at:     Time.zone.now )
        vs
      end

      def correct_resident_key?
        resident.authenticate(params[:resident_key])
      end

      def invalid_resident_key?
        resident && !resident.authenticate(params[:resident_key])
      end

      def generate_token
        SecureRandom.urlsafe_base64
      end

      def success_message
         "The email has been sent to the visitor. Thank you."
      end

      def failure_message
        msg = "Sorry. Something went wrong."
      end

end
