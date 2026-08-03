module Admin
  class DashboardController < BaseController
    def index
      @total_users = User.count
      @total_chickens = Chicken.count
      @total_matches = MatchCard.count
      @total_bets_volume = Bet.sum(:amount) || 0.0

      @recent_chickens = Chicken.includes(:user).order(created_at: :desc).limit(5)
      @upcoming_matches = MatchCard.order(scheduled_at: :asc).limit(5)
    end
  end
end
