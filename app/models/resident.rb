class Resident < ApplicationRecord
  has_secure_password
  validate :the_only_resident, on: :create
  validates :name, presence: true
  # validates :ic, presence: true
  validate :ic_must_be_present
  validates :phone, presence: true
  validates :email, presence: true
  validates :password, presence: true , length: { minimum: 6 }, allow_nil: true

  def Resident.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
                              BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost:cost)
  end

  # private

    def the_only_resident
      if Resident.find_by(floor: floor, unit: unit)
        errors.add(:base, "Resident has already been registered in the unit")
      end
    end

    def ic_must_be_present
      if ic.empty?
        errors.add(:base, "IC can't be blank")
      end
    end
end
