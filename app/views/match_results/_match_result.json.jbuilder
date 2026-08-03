json.extract! match_result, :id, :match_card_id, :winning_chicken_id, :win_method, :duration_seconds, :admin_notes, :created_at, :updated_at
json.url match_result_url(match_result, format: :json)
