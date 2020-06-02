class AddNameToVisitorPass < ActiveRecord::Migration[6.0]
  def change
    add_column :visitor_passes, :name, :string
  end
end
