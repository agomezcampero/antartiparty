class Api::V1::BetsController < Api::V1::BaseController
  def create
    respond_with Bet.create!(bet_params)
  end

  private

  def bet_params
    params.permit(:value, :game_id, :color).merge(user: current_user)
  end
end
