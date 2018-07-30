class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.date :date
      t.string :status
      t.integer :cost
      t.references :schedule, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
