class ResidentMailer < ApplicationMailer
  def registration(resident, password)
    @resident = resident
    @password = password
    mail to: resident.email, subject: "Registration Successful"
  end


  def visitor_details(visitor_pass)
    @visitor_pass = visitor_pass
    mail to: @visitor_pass.email, subject: "Please Submit Visitor Details"
  end

end
