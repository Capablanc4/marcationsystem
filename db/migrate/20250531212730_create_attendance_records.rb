class CreateAttendanceRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :attendance_records do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false
      t.time :time, null: false
      t.string :record_type, null: false
      t.text :comment
      t.timestamps
    end
    add_index :attendance_records, [ :user_id, :date ]
  end
end
