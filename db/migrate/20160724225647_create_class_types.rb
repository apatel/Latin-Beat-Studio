class CreateClassTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :class_types do |t|
      t.string :name, :null => false
      t.text :description
      t.boolean :active, default: true
      t.attachment :class_image
      t.integer :purchase
      t.string :color
      t.timestamps
    end

    add_index :class_types, :name, unique: true
    add_index :class_types, :description
  end
end
