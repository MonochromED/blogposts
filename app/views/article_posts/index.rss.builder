
#RSS feed builder for article posts

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Restaurant 2.0"
    xml.description "Reviews from everywhere"
    xml.link article_posts_url

    for article_post in @article_posts
      xml.item do 
        xml.title article_post.title
        xml.description article_post.article
        xml.pubDate article_post.date.to_s(:rfc822)
        xml.link article_post_url(article_post)
        xml.guid article_post_url(article_post)
      end
    end
  end
end

