class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :number
      t.string :source
      t.string :destinition
      t.references :airline, foreign_key: true

      t.timestamps
    end
  end
end
