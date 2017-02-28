class AddShopReferenceToOpeningHour < ActiveRecord::Migration[5.0]
  def change
    add_reference :shops, :opening_hour, index: true
    remove_column :shops, :category
  end
end
