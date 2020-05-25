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
                           from: 'whatsapp:+14155238886',
                           body: message,
                           to: "whatsapp:#{phone}"
                         )
  end

  private

      def account_sid
        ENV['ACCOUNT_SID']
      end

      def auth_token
        ENV['AUTH_TOKEN']
      end

end
