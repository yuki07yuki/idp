class CreateResidents < ActiveRecord::Migration[6.0]
  def change
    create_table :residents do |t|
      t.integer "floor"
      t.integer "unit"
      t.string "name"
      t.string "ic"
      t.string "phone"
      t.string "email"
      t.string "password_digest"

      t.timestamps
    end
  end
end
