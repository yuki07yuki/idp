class RenameEmail < ActiveRecord::Migration[6.0]
  def change
    rename_column :visitor_passes, :email, :visitors_email
  end
end
