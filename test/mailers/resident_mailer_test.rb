require 'test_helper'

class ResidentMailerTest < ActionMailer::TestCase

  def test_registration_email
    resident = residents(:resident_1_1)

    # Send the email, then test that it got queued
    email = ResidentMailer.registration_email(resident, password).deliver
    assert !ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal [resident.email], email.to
    assert_equal "Registration Successful", email.subject
    assert_match( password , email.body.encoded )
    assert_match '/visitor_passes/new', email.body.encoded
    
  end


  def password
    "000000"
  end

end
