class ChangeReviewToArticlePost < ActiveRecord::Migration
  def change
    rename_table :reviews, :article_posts
  end
end
