require "test_helper"

class GamesGadgetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get games_gadgets_index_url
    assert_response :success
  end
end
