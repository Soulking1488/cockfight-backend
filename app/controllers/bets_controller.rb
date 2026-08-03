# app/controllers/bets_controller.rb
class BetsController < ApplicationController
  before_action :require_user

  def index
    @bets = current_user.bets.includes(match_card: [:red_corner_chicken, :blue_corner_chicken]).order(created_at: :desc)
  end

  def create
    @match_card = MatchCard.find(params[:match_card_id])
    amount = params[:amount].to_f
    corner = params[:chosen_corner] # "red" or "blue"

    # Validation Checks
    unless @match_card.scheduled? || @match_card.ongoing?
      redirect_to match_card_path(@match_card), alert: "Bettng is closed for this match."
      return
    end

    if amount <= 0
      redirect_to match_card_path(@match_card), alert: "Please enter a valid bet amount."
      return
    end

    if current_user.wallet_balance < amount
      redirect_to match_card_path(@match_card), alert: "Insufficient wallet balance ($#{current_user.wallet_balance})."
      return
    end

    # Atomic Transaction: Create Bet & Deduct Funds
    ActiveRecord::Base.transaction do
      @bet = current_user.bets.create!(
        match_card: @match_card,
        amount: amount,
        chosen_corner: corner
      )
      current_user.update!(wallet_balance: current_user.wallet_balance - amount)
    end

    redirect_to match_card_path(@match_card), notice: "Satire bet of $#{amount} placed on the #{corner.upcase} corner!"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to match_card_path(@match_card), alert: e.message
  end
end
