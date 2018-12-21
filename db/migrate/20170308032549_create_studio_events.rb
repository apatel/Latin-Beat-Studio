class CreateStudioEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :studio_events do |t|
      t.string :name, :null => false
      t.datetime :start_date
      t.datetime :end_date
      t.text :description
      t.float :price
      t.string :url
      t.string :button_text
      t.boolean :active
      t.attachment :event_image
      t.timestamps
    end

    add_index :studio_events, :name, unique: true
    add_index :studio_events, :description
  end
end
