require 'test_helper'

class ResidentTest < ActiveSupport::TestCase

  def setup
    @admin = residents(:admin)
    @resident = Resident.new(floor: "1", unit: "1",
                              name: "Yuki",
                              ic: "TZ0775380",
                              phone: "0107939912",
                              email: "yuki07yuki@gmail.com",
                              password: "000000",
                              password_confirmation: "000000")
  end

  test 'only one resident in a unit' do
    # yml file already has a resident at unit 1-1
    assert_not @resident.valid?
    # not anybody on floor 20 
    @resident.floor = "20"
    assert @resident.valid?
  end

  test 'name cannot be empty' do
    @resident.name = ""
    assert_not @resident.valid?
  end

  test 'IC cannot be empty' do
    @resident.ic = ""
    assert_not @resident.valid?
  end

  test 'phone cannot be empty' do
    @resident.phone = ""
    assert_not @resident.valid?
  end

  test 'email cannot be empty' do
    @resident.email = ""
    assert_not @resident.valid?
  end

  test 'password cannot be empty' do
    @resident.password = ""
    @resident.password_confirmation = ""
    assert_not @resident.valid?
  end


end
