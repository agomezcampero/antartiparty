class Api::V1::GamesController < Api::V1::BaseController
  def create
    respond_with Game.create(game_params)
  end

  private

  def game_params
    params.permit(user_ids: [])
  end
end
