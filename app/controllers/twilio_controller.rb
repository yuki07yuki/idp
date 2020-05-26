class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    body = WhatsappHandler.new.process(params)
    response = Twilio::TwiML::MessagingResponse.new do |r|
     r.message body: body
    end
    render xml: response.to_s
  end


end
