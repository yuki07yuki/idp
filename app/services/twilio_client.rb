class TwilioClient
  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new account_sid, auth_token
  end


  def send_sms(phone, message)
    @client.messages.create(
                           from: '+14155238886',
                           body: message,
                           to: "+60107939912"
                         )
  end

  def send_whatsapp(phone, message)
    @client.messages.create(
                           from: "whatsapp:#{sender}",
                           body: message,
                           to: "whatsapp:#{phone}"
                         )
  end

  private

      def account_sid
        Rails.application.credentials.twilio[:account_sid]
      end

      def auth_token
        Rails.application.credentials.twilio[:auth_token]
      end

      def sender
        Rails.application.credentials.twilio[:sender]
      end

end
