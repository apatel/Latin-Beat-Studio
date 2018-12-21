class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name, :null => false
      t.integer :capacity
      t.text :description
      t.boolean :active, default: true
      t.timestamps
    end

    add_index :locations, :name, unique: true
  end
end
