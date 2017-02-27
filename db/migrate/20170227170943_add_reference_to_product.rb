class AddReferenceToProduct < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :shop, foreign_key: true
  end
end
