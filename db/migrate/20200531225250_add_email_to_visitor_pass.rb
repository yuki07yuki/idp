class AddEmailToVisitorPass < ActiveRecord::Migration[6.0]
  def change
    add_column :visitor_passes, :email, :string
  end
end
