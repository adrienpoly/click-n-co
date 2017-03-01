class RemoveReferenceOnOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :ordered_product_id
    add_reference :ordered_products, :order, index: true
  end
end
