class CreateJoinTableClassTypesInstructors < ActiveRecord::Migration[5.0]
  def change
    create_join_table :class_types, :instructors do |t|
      #t.index [:class_type_id, :instructor_id]
    end
  end
end
