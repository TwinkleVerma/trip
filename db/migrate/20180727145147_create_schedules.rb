class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.time :depart_time
      t.time :arrival_time
      t.string :day
      t.integer :base_cost
      t.references :flight, foreign_key: true

      t.timestamps
    end
  end
end
