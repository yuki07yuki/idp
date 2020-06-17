require 'test_helper'

class LocaleMessageTest <  ActionDispatch::IntegrationTest

# Sessions Controller
  test 'successful login message' do
    assert_equal 'Successfully logged in.',
      I18n.t('sessions.create.success')
  end

  test 'invalid username or password message' do
    assert_equal 'Invalid username or password.',
      I18n.t('sessions.create.failure')
  end

  test 'successful logout message' do
    assert_equal 'Successfully logged out.',
      I18n.t('sessions.destroy.success')
  end

# Resident Controller
  test 'resident successful registration message' do
    assert_equal 'Resident successfully registered.',
      I18n.t('residents.create.success')
  end

  test 'duplicate registration message' do
    assert_equal 'Resident has already been registered in the unit.',
      I18n.t('residents.create.failure.duplicate')
  end

  test 'successful update message' do
    assert_equal 'Successfully updated.',
      I18n.t('residents.update.success')
  end

  test 'successful destroy message' do
    assert_equal 'Successfully deleted.',
      I18n.t('residents.destroy.success')
  end


# Visitors Controller

  test 'expired link message' do
    assert_equal  "This link has been expired. Please ask the resident to apply for a new visitor pass.",
      I18n.t('visitors.new.failure.expired')
  end

  test 'invalid link message' do
    assert_equal  "Invalid link.",
      I18n.t('visitors.new.failure.invalid')
  end

  test 'QR code has been sent message' do
    assert_equal  "The QR code has been sent to your email.",
      I18n.t('visitors.create.success')
  end

  test 'wrong secret key message' do
    assert_equal  "Please ask the resident for the correct secret key.",
      I18n.t('visitors.create.failure.secret_key')
  end

#VisitorPass Controller
  test 'The email has been sent message' do
    assert_equal   "The email has been sent to the visitor. Thank you.",
      I18n.t('visitor_passes.create.success')
  end

  test 'Invalid resdient key message' do
    assert_equal  "Resident key is invalid.",
      I18n.t('visitor_passes.create.failure.resident_key')
  end
end
