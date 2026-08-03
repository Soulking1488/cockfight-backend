require "test_helper"

class MatchResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match_result = match_results(:one)
  end

  test "should get index" do
    get match_results_url
    assert_response :success
  end

  test "should get new" do
    get new_match_result_url
    assert_response :success
  end

  test "should create match_result" do
    assert_difference("MatchResult.count") do
      post match_results_url, params: { match_result: { admin_notes: @match_result.admin_notes, duration_seconds: @match_result.duration_seconds, match_card_id: @match_result.match_card_id, win_method: @match_result.win_method, winning_chicken_id: @match_result.winning_chicken_id } }
    end

    assert_redirected_to match_result_url(MatchResult.last)
  end

  test "should show match_result" do
    get match_result_url(@match_result)
    assert_response :success
  end

  test "should get edit" do
    get edit_match_result_url(@match_result)
    assert_response :success
  end

  test "should update match_result" do
    patch match_result_url(@match_result), params: { match_result: { admin_notes: @match_result.admin_notes, duration_seconds: @match_result.duration_seconds, match_card_id: @match_result.match_card_id, win_method: @match_result.win_method, winning_chicken_id: @match_result.winning_chicken_id } }
    assert_redirected_to match_result_url(@match_result)
  end

  test "should destroy match_result" do
    assert_difference("MatchResult.count", -1) do
      delete match_result_url(@match_result)
    end

    assert_redirected_to match_results_url
  end
end
