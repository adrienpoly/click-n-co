class FixTotalPriceToOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :total_price
    add_monetize :orders, :total_price, currency: { present: false }
  end
end
