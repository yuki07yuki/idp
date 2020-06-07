class CreateVisitors < ActiveRecord::Migration[6.0]
  def change
    create_table :visitors do |t|
      t.string :name
      t.string :ic
      t.string :phone
      t.string :email
      t.string :car_no
      t.string :secret_key

      t.timestamps
    end
  end
end
