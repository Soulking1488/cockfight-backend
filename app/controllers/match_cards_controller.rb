# app/controllers/match_cards_controller.rb
class MatchCardsController < ApplicationController
  def index
    @upcoming_matches = MatchCard.includes(:red_corner_chicken, :blue_corner_chicken)
                                 .where(status: [:scheduled, :ongoing])
                                 .order(scheduled_at: :asc)

    @past_matches = MatchCard.includes(:red_corner_chicken, :blue_corner_chicken, :match_result)
                             .where(status: [:completed, :cancelled])
                             .order(scheduled_at: :desc)
                             .limit(5)
  end

  def show
    @match_card = MatchCard.includes(:red_corner_chicken, :blue_corner_chicken).find(params[:id])
    @user_bet = logged_in? ? @match_card.user_bet_for(current_user) : nil
  end
end
