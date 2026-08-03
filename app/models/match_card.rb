# app/models/match_card.rb
class MatchCard < ApplicationRecord
  belongs_to :red_corner_chicken, class_name: "Chicken"
  belongs_to :blue_corner_chicken, class_name: "Chicken"
  has_many :bets, dependent: :destroy
  has_one :match_result, dependent: :destroy

  enum :status, { scheduled: 0, ongoing: 1, completed: 2, cancelled: 3 }, default: :scheduled

  validates :title, presence: true
  validates :scheduled_at, presence: true
  validates :house_bet_red, numericality: { greater_than_or_equal_to: 0 }
  validates :house_bet_blue, numericality: { greater_than_or_equal_to: 0 }

  # Total pool in Red Corner (House seed + User bets)
  def total_red_pool
    house_bet_red + bets.where(chosen_corner: "red").sum(:amount)
  end

  # Total pool in Blue Corner (House seed + User bets)
  def total_blue_pool
    house_bet_blue + bets.where(chosen_corner: "blue").sum(:amount)
  end

  def total_pool
    total_red_pool + total_blue_pool
  end

  # Multiplier odds (e.g. 1.85x payout)
  def red_odds
    return 2.00 if total_red_pool.zero?
    (total_pool / total_red_pool).round(2)
  end

  def blue_odds
    return 2.00 if total_blue_pool.zero?
    (total_pool / total_blue_pool).round(2)
  end

  def user_bet_for(user)
    bets.find_by(user: user)
  end
end
