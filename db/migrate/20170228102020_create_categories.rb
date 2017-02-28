class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.text :descritpion

      t.timestamps
    end
  end
end
