class CreateSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :schedules do |t|
      t.string :day_of_week
      t.time :start_time
      t.time :end_time
      t.string :activity

      t.timestamps
    end
  end
end
