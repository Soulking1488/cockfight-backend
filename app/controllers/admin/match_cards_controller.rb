module Admin
  class MatchCardsController < BaseController
    def new
      @match_card = MatchCard.new
      # Load all chickens so admin can select Red and Blue fighters
      @chickens = Chicken.includes(:user).all
    end

    def create
      @match_card = MatchCard.new(match_card_params)
      @match_card.status ||= "scheduled"

      if @match_card.red_corner_chicken_id == @match_card.blue_corner_chicken_id
        flash.now[:alert] = "A rooster cannot fight itself! Choose two different fighters."
        @chickens = Chicken.includes(:user).all
        render :new, status: :unprocessable_entity
        return
      end

      if @match_card.save
        redirect_to admin_dashboard_path, notice: "Match Card '#{@match_card.title}' successfully booked!"
      else
        @chickens = Chicken.includes(:user).all
        render :new, status: :unprocessable_entity
      end
    end

    private

    def match_card_params
      params.require(:match_card).permit(
        :title, 
        :scheduled_at, 
        :red_corner_chicken_id, 
        :blue_corner_chicken_id, 
        :house_bet_red, 
        :house_bet_blue,
        :status
      )
    end
  end
end
