class Review < ActiveRecord::Base

  validates :title, :presence => true #checks for the 'title' field if filled
  validates :poster, :presence => true #checks for field filled
  has_many :comments
end
