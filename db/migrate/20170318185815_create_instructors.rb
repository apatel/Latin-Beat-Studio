class CreateInstructors < ActiveRecord::Migration[5.0]
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :title
      t.text :playlist
      t.references :user
      t.attachment :instructor_image
      t.string :fb_handle
      t.string :fb_link
      t.string :ig_handle
      t.string :ig_link
      t.text :bio
      t.integer :view_order
      t.timestamps
    end

    add_index :instructors, :name, unique: true
    add_index :instructors, :title
  end
end
