class ChangeUserIdFieldColumn < ActiveRecord::Migration
  def change
    rename_column :users, :userid, :user_id
  end
end
