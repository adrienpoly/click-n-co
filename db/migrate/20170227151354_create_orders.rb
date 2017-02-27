class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.float :total_price
      t.references :ordered_product, foreign_key: true
      t.datetime :pick_up_at
      t.references :user, foreign_key: true
      t.text :instructions
      t.string :status

      t.timestamps
    end
  end
end
