class RenameColumnDescritpionFromCategory < ActiveRecord::Migration[5.0]
  def change
    rename_column :categories, :descritpion, :name
  end
end
