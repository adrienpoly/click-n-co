class CreateOpeningHours < ActiveRecord::Migration[5.0]
  def change
    create_table :opening_hours do |t|
      t.string :day
      t.time :open_time
      t.time :closed_time
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
