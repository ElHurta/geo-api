class AddTypeToFeatures < ActiveRecord::Migration[7.1]
  def change
    add_column :features, :type, :string
  end
end
