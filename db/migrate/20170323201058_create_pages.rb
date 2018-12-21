class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :code
      t.text :content
      t.boolean :show_in_menu
      t.integer :purchase
      t.timestamps
    end
  end
end
