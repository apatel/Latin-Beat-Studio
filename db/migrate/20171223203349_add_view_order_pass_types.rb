class AddViewOrderPassTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :pass_types, :view_order, :integer
  end
end
