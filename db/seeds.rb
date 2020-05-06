# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1.upto(10) do |floor|
  1.upto(15) do |unit|

    r = Resident.new(floor: floor,
                      unit: unit,
                      name: Faker::FunnyName.name,
                      ic: Faker::IDNumber.valid,
                      phone: Faker::PhoneNumber.cell_phone_in_e164,
                      email: Faker::Internet.email,
                      password:              "000000",
                      password_confirmation: "000000"
                    )
    r.save
  end
end
