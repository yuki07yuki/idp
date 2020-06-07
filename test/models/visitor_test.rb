require 'test_helper'

class VisitorTest < ActiveSupport::TestCase
  def setup
    @visitor = Visitor.new(name: "Yuki",
                           ic: "TZ0775380",
                           phone: "0107939912",
                           email: "yuki07yuki@gmail.com",
                           car_no: "wtu2348",
                           secret_key: "banana")
  end

  test 'cannot have any empty field' do
    [:name, :ic, :phone, :email, :secret_key].each do |field|
      @visitor.send("#{field.to_s}=", "")
      assert_not @visitor.valid?, "#{field} should not be allowed empty"
    end


  end

  test 'car number can be empty' do
    @visitor.car_no = ""
    assert @visitor.valid?
  end

end
