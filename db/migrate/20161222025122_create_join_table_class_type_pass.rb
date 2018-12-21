class CreateJoinTableClassTypePass < ActiveRecord::Migration[5.0]
  def change
    create_join_table :class_types, :passes do |t|
      t.index [:class_type_id, :pass_id]
    end
  end
end
