class ChangeCommentsReviewIdToArticlePostIdInDb < ActiveRecord::Migration
  def change
    rename_column :comments, :review_id, :article_post_id
  end
end
