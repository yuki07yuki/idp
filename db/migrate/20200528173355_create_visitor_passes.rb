class CreateVisitorPasses < ActiveRecord::Migration[6.0]
  def change
    create_table :visitor_passes do |t|
      t.string :resident_id
      t.string :token
      t.datetime :requested_at
      t.boolean :valid , default: true
      t.timestamps
    end
  end
end
