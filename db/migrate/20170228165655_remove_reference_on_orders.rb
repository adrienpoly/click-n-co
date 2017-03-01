class RemoveReferenceOnOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :ordered_product_id
    #remove_reference(:orders, :ordered_product, index: true)
    #add_reference :ordered_products, :order, index: true
  end
end
