class CreateClassRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :class_registrations do |t|
      t.integer :fullcalendar_engine_events_id
      t.references :class_type
      t.references :user
      t.references :purchase
      t.boolean :attended
      t.boolean :no_show
      t.datetime :class_date
      t.timestamps
    end
  end
end
