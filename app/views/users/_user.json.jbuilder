json.extract! user, :id, :name, :email, :role, :wallet_balance, :created_at, :updated_at
json.url user_url(user, format: :json)
