json.array!(@bookmarks) do |bookmark|
  json.extract! bookmark, :url, :title, :screenshot
  json.url bookmark_url(bookmark, format: :json)
end
