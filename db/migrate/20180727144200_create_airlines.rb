class CreateAirlines < ActiveRecord::Migration[5.2]
  def change
    create_table :airlines do |t|
      t.string :name
      t.references :profile, polymorphic: true, index: true
      t.timestamps
    end
  end
end
