class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.references :user
      t.references :pass
      t.datetime :expire
      t.boolean :paid, default: false
      t.boolean :suspend, default: false
      t.datetime :suspend_start
      t.datetime :suspend_end
      t.integer :remaining_days
      t.timestamps
    end
  end
end
