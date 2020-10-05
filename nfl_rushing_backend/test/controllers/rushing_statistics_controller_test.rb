require 'test_helper'

class RushingStatisticsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rushing_statistic = rushing_statistics(:one)
  end

  test "should get index" do
    get rushing_statistics_url, as: :json
    assert_response :success
  end

  test "should create rushing_statistic" do
    assert_difference('RushingStatistic.count') do
      post rushing_statistics_url, params: { rushing_statistic: { player_name: @rushing_statistic.player_name, position: @rushing_statistic.position, team: @rushing_statistic.team } }, as: :json
    end

    assert_response 201
  end

  test "should show rushing_statistic" do
    get rushing_statistic_url(@rushing_statistic), as: :json
    assert_response :success
  end

  test "should update rushing_statistic" do
    patch rushing_statistic_url(@rushing_statistic), params: { rushing_statistic: { player_name: @rushing_statistic.player_name, position: @rushing_statistic.position, team: @rushing_statistic.team } }, as: :json
    assert_response 200
  end

  test "should destroy rushing_statistic" do
    assert_difference('RushingStatistic.count', -1) do
      delete rushing_statistic_url(@rushing_statistic), as: :json
    end

    assert_response 204
  end
end
