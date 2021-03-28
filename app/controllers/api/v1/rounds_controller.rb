class Api::V1::RoundsController < Api::V1::BaseController
  def create
    respond_with Round.create(round_params)
  end

  private

  def round_params
    params.permit(:game_id)
  end
end
