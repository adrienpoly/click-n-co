class AddReferenceToCategory < ActiveRecord::Migration[5.0]
  def change
    add_reference :shops, :category, index: true
  end
end
