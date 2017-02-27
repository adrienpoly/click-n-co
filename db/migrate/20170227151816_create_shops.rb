class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :description
      t.string :address
      t.string :phone_number
      t.string :category
      t.string :color_theme
      t.references :user, foreign_key: true


      t.timestamps
    end
  end
end
