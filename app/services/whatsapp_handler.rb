class WhatsappHandler
  def process(params)
    phone = params["From"]
    body = params["Body"]

    "You messaged us saying..... #{body}!"
    # check the phone? to see if its resident or visitor
    if resident? phone
      # start the resident chat
    elsif visitor? phone
      # start the visitor chat   
    end

  end

end
