class CreatePasses < ActiveRecord::Migration[5.0]
  def change
    create_table :passes do |t|
      t.string :name, :null => false
      t.text :description
      t.float :price
      t.integer :expiration_days, default: 30
      t.integer :quantity
      t.boolean :active, default: true
      t.string :embed_code
      t.integer :purchase
      t.string :category
      t.integer :view_order
      t.timestamps
    end

    add_index :passes, :name, unique: true
    add_index :passes, :description
    add_index :passes, :price
    add_index :passes, :expiration_days
    add_index :passes, :quantity
  end
end
