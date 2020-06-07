class Visitor < ApplicationRecord
  validates :name, presence: true
  validates :ic, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :secret_key, presence: true
end
