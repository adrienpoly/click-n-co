class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.references :product_category, foreign_key: true
      t.string :name
      t.text :description
      t.string :short_description
      t.float :price
      t.string :measurement_units

      t.timestamps
    end
  end
end
