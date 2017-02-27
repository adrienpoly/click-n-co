class AddReferenceToShop < ActiveRecord::Migration[5.0]
  def change
    add_reference :shops, :product, foreign_key: true
  end
end
