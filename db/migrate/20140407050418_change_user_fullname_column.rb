class ChangeUserFullnameColumn < ActiveRecord::Migration
  def change
    rename_column :users, :fullname, :full_name
  end
end
