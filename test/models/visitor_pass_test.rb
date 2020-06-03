require 'test_helper'

class VisitorPassTest < ActiveSupport::TestCase

  def setup
    @resident1 = residents(:resident_1_1)
    @visitor_pass = VisitorPass.new(
                                    resident_id:    @resident1.id,
                                    visitors_name:  "athiga",
                                    visitors_email: "yuki07yuki@gmail.com",
                                    token:          generate_token,
                                    secret_key:     "banana" )

  end

  test 'resident_id should not be empty' do
    @visitor_pass.resident_id = ""
    assert_not @visitor_pass.valid?
  end


  test "visitor's name should not be empty" do
    @visitor_pass.visitors_name = ""
    assert_not @visitor_pass.valid?
  end

  test "visitor's email should not be empty" do
    @visitor_pass.visitors_email = ""
    assert_not @visitor_pass.valid?
  end

  test 'token should not be empty' do
    @visitor_pass.token = ""
    assert_not @visitor_pass.valid?
  end

  test "secret_key should not be empty" do
    @visitor_pass.secret_key = ""
    assert_not @visitor_pass.valid?
  end


  private

    def generate_token
      SecureRandom.urlsafe_base64
    end



end
