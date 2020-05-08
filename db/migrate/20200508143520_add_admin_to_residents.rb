class AddAdminToResidents < ActiveRecord::Migration[6.0]
  def change
    add_column :residents, :admin, :boolean, default: false
  end
end
