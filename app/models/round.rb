class Round < ApplicationRecord
  include PowerTypes::Observable

  belongs_to :game
  has_many :bets

  validate :previous_round_complete?
  before_save :set_values

  def complete?
    game.users.count == bets.count
  end

  def set_values
    self.number = Round.where(game: game).count + 1
    self.white = [1, 2, 3, 5, 5, 7].sample
    self.blue = [1, 2, 3, 4, 4, -2].sample
  end

  def previous_round_complete?
    previous_round = Round.where(game: game).last
    return unless previous_round

    errors.add(:number, 'previous round is not complete') unless previous_round.complete?
  end

  def calculate_winners
    return calculate_loser if blue == -2

    calculate_winner(:white, blue == white ? 2 : 1)
    calculate_winner(:blue)
  end

  def calculate_winner(color, multiplier = 1)
    values = bets.send(color).order(value: :desc).pluck(:value)
    winner_value = values.filter_map { |v| values.count(v) == 1 ? v : nil }.max
    if winner_value
      bets.send(color).find_by(value: winner_value).update(winner: true, points: send(color) * multiplier)
    end
  end

  def calculate_loser
    values = bets.order(value: :desc).pluck(:value)
    loser_value = values.filter_map { |v| values.count(v) == 1 ? v : nil }.min
    bets.where.not(value: loser_value).update(winner: true)
    if loser_value
      bets.find_by(value: loser_value).update(points: -2)
    end
  end
end

# == Schema Information
#
# Table name: rounds
#
#  id         :bigint(8)        not null, primary key
#  number     :integer
#  white      :integer
#  blue       :integer
#  game_id    :bigint(8)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_rounds_on_game_id  (game_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#
