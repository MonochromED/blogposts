class ChangeNewsToAnnouncements < ActiveRecord::Migration
  def change
    rename_table :news, :announcements
  end
end
