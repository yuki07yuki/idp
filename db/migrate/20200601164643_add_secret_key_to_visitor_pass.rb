class AddSecretKeyToVisitorPass < ActiveRecord::Migration[6.0]
  def change
    add_column :visitor_passes, :secret_key, :string
  end
end
