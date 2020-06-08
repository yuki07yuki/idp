class RenameCarNo < ActiveRecord::Migration[6.0]
  def change
    rename_column :visitors, :car_no, :car

  end
end
