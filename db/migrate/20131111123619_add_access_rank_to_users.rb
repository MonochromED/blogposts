class AddAccessRankToUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_rank, :integer
  end
end
