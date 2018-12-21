class AddSinglePurchaseToPasses < ActiveRecord::Migration[5.0]
  def change
    add_column :passes, :single_purchase, :boolean, default: false
  end
end
