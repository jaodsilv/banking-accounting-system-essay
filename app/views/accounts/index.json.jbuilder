json.array!(@accounts) do |account|
  json.extract! account, :id, :balance
  json.url account_url(account, format: :json)
end
