class ResidentMailer < ApplicationMailer
  def registration(resident, password)
    @resident = resident
    @password = password
    mail to: resident.email, subject: "Registration Successful"
  end


  def visitor_details(visitor_pass, resident)
    @visitor_pass = visitor_pass
    @resident = resident
    mail to: resident.email, subject: "Please Submit Visitor Details"
  end

end
