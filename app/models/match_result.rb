# app/models/match_result.rb
class MatchResult < ApplicationRecord
  belongs_to :match_card
  belongs_to :winning_chicken, class_name: "Chicken"

  validates :win_method, presence: true # e.g. "KO", "TKO", "Decision", "Opponent Fled"
  validates :winning_chicken_id, presence: true

  # Helper to identify if Red or Blue corner won
  def winning_corner
    if winning_chicken_id == match_card.red_corner_chicken_id
      "red"
    elsif winning_chicken_id == match_card.blue_corner_chicken_id
      "blue"
    end
  end
end
