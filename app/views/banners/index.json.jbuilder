json.array!(@banners) do |banner|
  json.extract! banner, :id, :kind, :description, :state, :keywords, :rank, :image, :production_order_id
  json.url banner_url(banner, format: :json)
end
