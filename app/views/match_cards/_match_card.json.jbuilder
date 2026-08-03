json.extract! match_card, :id, :title, :scheduled_at, :red_corner_chicken_id, :blue_corner_chicken_id, :status, :odds_red, :odds_blue, :created_at, :updated_at
json.url match_card_url(match_card, format: :json)
