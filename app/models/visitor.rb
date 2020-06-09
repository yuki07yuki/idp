class Visitor < ApplicationRecord
  validates :name, presence: true
  validate  :ic_must_be_present
  validates :phone, presence: true
  validates :email, presence: true
  validates :secret_key, presence: true

  private

      def ic_must_be_present
        if ic.empty?
          errors.add(:base, "IC can't be blank")
        end
      end
end
