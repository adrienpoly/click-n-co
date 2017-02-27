class FixColumnDescriptionToShops < ActiveRecord::Migration[5.0]
  def change
    change_column :shops, :description, :text
  end
end
