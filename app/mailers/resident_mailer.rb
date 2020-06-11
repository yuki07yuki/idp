class ResidentMailer < ApplicationMailer
  def registration_email(resident, password)
    @resident = resident
    @password = password
    mail to: resident.email, subject: "Registration Successful"
  end


  def visitor_details(visitor_pass)
    @visitor_pass = visitor_pass
    mail to: @visitor_pass.visitors_email, subject: "Please Submit Your Details"
  end

  def qrcode(visitor, qrcode)
    @visitor = visitor
    @qrcode = qrcode
    mail to: @visitor.email, subject: "QR code for your visitor pass".capitalize
  end
end
