class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :f_name, :string
    add_column :users, :l_name, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :role, :string
  end
end
