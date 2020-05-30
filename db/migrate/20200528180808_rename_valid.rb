class RenameValid < ActiveRecord::Migration[6.0]
  def change
    rename_column :visitor_passes, :valid, :active
  end
end
