class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.belongs_to :user, index: true
      t.string :callfrom
      t.integer :duration
      t.string :callSid
      t.string :status
      t.string :accountSid
      t.timestamps
    end
  end
end



