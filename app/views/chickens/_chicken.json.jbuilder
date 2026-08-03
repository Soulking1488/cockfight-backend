json.extract! chicken, :id, :user_id, :name, :weight, :weight_class, :record_wins, :record_losses, :status, :created_at, :updated_at
json.url chicken_url(chicken, format: :json)
