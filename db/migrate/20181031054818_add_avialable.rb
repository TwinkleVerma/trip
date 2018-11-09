class AddAvialable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avialable, :integer
  end
end
