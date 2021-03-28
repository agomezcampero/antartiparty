class GamesController < ApplicationController
  include AuthConcern

  before_action :check_user_signed_in

  def show
    redirect_to '/users/sign_in' unless current_user

    @game = Game.find(params[:id])
    @users = @game.users
    @round = @game.rounds.last
    set_starting_attributes
  end

  def new
    @users = User.all.map { |user| { id: user.id, email: user.email }}
  end

  private

  def set_starting_attributes
    @starting_bets_missing = @users.size - (@round&.bets&.count || 0)
    used_values = Bet.where(user: current_user, game: @game).pluck(:value)
    @starting_available_numbers = (1..15).to_a.filter_map do |val| 
      used_values.include?(val) ? nil : val
    end
    @current_standings = @game.standings
    @starting_bet_placed = !!Bet.find_by(user: current_user, round: @round)
  end
end
