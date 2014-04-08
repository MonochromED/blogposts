class Announcement < ActiveRecord::Base
  validates :title, :presence => true #checks for the 'title' field if filled
end
