class RenameNameToAvatar < ActiveRecord::Migration[5.2]
  def change
    rename_column :images, :name, :avatar
  end
end
