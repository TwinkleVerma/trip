class CreateDisableSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :disable_schedules do |t|
      t.date :date
      t.references :schedule, foreign_key: true
      t.timestamps
    end
  end
end
