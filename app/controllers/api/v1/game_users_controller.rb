class Api::V1::GameUsersController < Api::V1::BaseController
  def create
    respond_with current_user.game_users.create(game_id: params[:game_id])
  end
end
