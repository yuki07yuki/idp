class ResidentMailer < ApplicationMailer
  def registration(resident, password)
    @resident = resident
    @password = password
    mail to: resident.email, subject: "Registration Successful"
  end


  def visitor_details_email

  end

end
