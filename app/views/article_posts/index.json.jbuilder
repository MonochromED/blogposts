json.array!(@article_posts) do |article_post|
  json.extract! article_post, :poster, :date, :article
  json.url article_post_url(article_post, format: :json)
end
