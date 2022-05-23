require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get games_new_url
    assert_response :success
  end

  test "should get score" do
    get games_score_url
    assert_response :success
  end
end
