class RenameName < ActiveRecord::Migration[6.0]
  def change
    rename_column :visitor_passes, :name, :visitors_name
  end
end
