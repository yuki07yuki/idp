ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/reporters"

Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def login_as(user)
    session[:user_id] = user.id
  end

  def flash__cleared?
    get root_path
    assert flash.empty?
  end


end


class ActionDispatch::IntegrationTest

  def login_as(user, password: '000000')
    post login_path,
      params: { session: { username: user.name, password: password }}
  end

end
