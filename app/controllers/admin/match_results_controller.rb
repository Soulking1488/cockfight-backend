module Admin
  class MatchResultsController < BaseController
    def new
      @match_card = MatchCard.find(params[:match_card_id])
      @match_result = MatchResult.new
    end

    def create
      @match_card = MatchCard.find(params[:match_card_id])

      if @match_card.completed?
        redirect_to admin_dashboard_path, alert: "This match has already been settled."
        return
      end

      winning_chicken_id = params[:match_result][:winning_chicken_id].to_i
      win_method = params[:match_result][:win_method]
      details = params[:match_result][:details]

      winning_chicken = Chicken.find(winning_chicken_id)
      losing_chicken = (winning_chicken_id == @match_card.red_corner_chicken_id) ? @match_card.blue_corner_chicken : @match_card.red_corner_chicken
      winning_corner = (winning_chicken_id == @match_card.red_corner_chicken_id) ? "red" : "blue"

      # Execute fight settlement & wallet payouts atomically
      ActiveRecord::Base.transaction do
        # 1. Record Match Result
        @match_result = MatchResult.create!(
          match_card: @match_card,
          winning_chicken: winning_chicken,
          win_method: win_method,
          details: details
        )

        # 2. Update Match Card Status
        @match_card.completed!

        # 3. Update Roosters' Fight Records
        winning_chicken.increment!(:record_wins)
        losing_chicken.increment!(:record_losses)

        # 4. Calculate Odds & Distribute Bet Payouts
        total_winning_pool = (winning_corner == "red") ? @match_card.total_red_pool : @match_card.total_blue_pool
        total_event_pool = @match_card.total_pool

        # Odds multiplier = Total Pool / Winning Corner Pool
        multiplier = total_winning_pool.positive? ? (total_event_pool / total_winning_pool) : 1.0

        # Find all winning bets placed on this match
        winning_bets = @match_card.bets.where(chosen_corner: winning_corner)

        winning_bets.each do |bet|
          payout_amount = (bet.amount * multiplier).round(2)
          # Credit payout to user's satire wallet
          bet.user.update!(wallet_balance: bet.user.wallet_balance + payout_amount)
        end
      end

      redirect_to admin_dashboard_path, notice: "Match settled! Winnings distributed to winning bettors."
    rescue => e
      flash.now[:alert] = "Failed to settle match: #{e.message}"
      render :new, status: :unprocessable_entity
    end
  end
end
