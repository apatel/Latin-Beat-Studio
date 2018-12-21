class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.string :title
      t.text :body
      t.string :page
      t.string :section
      t.attachment :content_image
      t.timestamps
    end
  end
end
