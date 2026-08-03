require "test_helper"

class MatchCardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match_card = match_cards(:one)
  end

  test "should get index" do
    get match_cards_url
    assert_response :success
  end

  test "should get new" do
    get new_match_card_url
    assert_response :success
  end

  test "should create match_card" do
    assert_difference("MatchCard.count") do
      post match_cards_url, params: { match_card: { blue_corner_chicken_id: @match_card.blue_corner_chicken_id, odds_blue: @match_card.odds_blue, odds_red: @match_card.odds_red, red_corner_chicken_id: @match_card.red_corner_chicken_id, scheduled_at: @match_card.scheduled_at, status: @match_card.status, title: @match_card.title } }
    end

    assert_redirected_to match_card_url(MatchCard.last)
  end

  test "should show match_card" do
    get match_card_url(@match_card)
    assert_response :success
  end

  test "should get edit" do
    get edit_match_card_url(@match_card)
    assert_response :success
  end

  test "should update match_card" do
    patch match_card_url(@match_card), params: { match_card: { blue_corner_chicken_id: @match_card.blue_corner_chicken_id, odds_blue: @match_card.odds_blue, odds_red: @match_card.odds_red, red_corner_chicken_id: @match_card.red_corner_chicken_id, scheduled_at: @match_card.scheduled_at, status: @match_card.status, title: @match_card.title } }
    assert_redirected_to match_card_url(@match_card)
  end

  test "should destroy match_card" do
    assert_difference("MatchCard.count", -1) do
      delete match_card_url(@match_card)
    end

    assert_redirected_to match_cards_url
  end
end
