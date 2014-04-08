class Comment < ActiveRecord::Base
  belongs_to :article_post
end
