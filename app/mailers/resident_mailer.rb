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

  def qrcode(visitor, qrcode_path)
    @visitor = visitor
    attachments.inline['qrcode.png'] = File.read(qrcode_path)
    mail to: @visitor.email, subject: "QR code for your visitor pass"
  end
end
