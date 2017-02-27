class CreateOrderedProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :ordered_products do |t|
      t.references :product, foreign_key: true
      t.float :quantity
      t.float :order_price

      t.timestamps
    end
  end
end
