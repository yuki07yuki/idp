require 'pry'

class VisitorsController < ApplicationController

  def new
    # either resident or pass is wrong
    if !resident || !visitor_pass
      flash.now[:danger] = t('visitors.new.failure.invalid')
      render "home_pages/home"
      return
    end

    if visitor_pass.expired?
      flash.now[:danger] = t('visitors.new.failure.expired')
      render "home_pages/home"
      return
    end

    if !visitor_pass.active?
      flash.now[:danger] = t('visitors.new.failure.used')
      render "home_pages/home"
      return
    end

    @visitor = Visitor.new
    @visitor_pass = visitor_pass
    @resident = resident

  end

  def create
    @visitor = Visitor.new(visitor_params)
    @visitor_pass = VisitorPass.find_by(id: params['visitor_pass_id'])
    @resident = Resident.find_by(id: params['resident_id'])

    # verify the secret key submitted by the visitor
    if correct_secret_key? && @visitor.save
      send_qrcode
      # qrcode_client = QrcodeClient.new
      # qrcode_client.generate2(resident: @resident, visitor: @visitor, path: path)
      # ResidentMailer.qrcode(@visitor, path).deliver_now

      @visitor_pass.update(active: false)

      flash.now[:success] = t('visitor.create.success')
      render 'home_pages/home'
    else
      unless correct_secret_key?
        @visitor.errors.delete :secret_key
        @visitor.errors.add(:secret_key,t('visitors.create.failure.secret_key'))
      end
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

      def send_qrcode
        qrcode_client = QrcodeClient.new
        qrcode_client.generate2(resident: @resident, visitor: @visitor, path: path)
        ResidentMailer.qrcode(@visitor, path).deliver_now

      end
end
