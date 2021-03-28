class Api::V1::GamesController < Api::V1::BaseController
  def create
    respond_with Game.create(game_params)
  end

  private

  def game_params
    current_user ? { users: [current_user] } : nil
  end
end
