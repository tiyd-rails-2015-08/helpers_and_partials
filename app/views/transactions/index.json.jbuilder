json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :description, :recipient, :type, :amount
  json.url transaction_url(transaction, format: :json)
end
