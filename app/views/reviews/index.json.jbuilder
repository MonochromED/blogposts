json.array!(@reviews) do |review|
  json.extract! review, :poster, :date, :article
  json.url review_url(review, format: :json)
end
