class HomeController < ApplicationController
  def index
    redirect_to current_user ? game_path(current_user.games.last) : new_user_session_path
  end
end
