class Api::V1::UsersController < Api::V1::BaseController
  def create
    user = User.create!(user_params)
    user.game_users.create(game_id: params[:game_id]) if params[:game_id]
    sign_in(user)
    respond_with user
  end

  private

  def user_params
    params.permit(:username).merge(password: '12345678', email: "user-#{User.last.id + 1}@ap.com")
  end
end
