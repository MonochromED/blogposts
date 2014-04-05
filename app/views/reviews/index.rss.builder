
#RSS feed builder for reviews

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Restaurant 2.0"
    xml.description "Reviews from everywhere"
    xml.link reviews_url

    for review in @reviews
      xml.item do 
        xml.title review.title
        xml.description review.article
        xml.pubDate review.date.to_s(:rfc822)
        xml.link review_url(review)
        xml.guid review_url(review)
      end
    end
  end
end

