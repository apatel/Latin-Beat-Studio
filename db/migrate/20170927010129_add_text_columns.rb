class AddTextColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :passes, :expiration_text, :string
    add_column :passes, :quantity_text, :string
  end
end
