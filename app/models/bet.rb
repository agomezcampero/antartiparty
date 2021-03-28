class Bet < ApplicationRecord
  include PowerTypes::Observable

  belongs_to :user
  belongs_to :game
  belongs_to :round

  before_validation :set_round
  validates :round, uniqueness: { scope: [:game, :user] }
  validates :value, uniqueness: { scope: [:game, :user] }
  validates :value, presence: true
  validates :value, numericality: { greather_than: 0, less_than: 16}

  scope :white, -> { where(color: 'white') }
  scope :blue, -> { where(color: 'blue') }

  def set_round
    self.round = Round.where(game_id: game_id).last
    self.color = 'blue' if round.blue == -2
    self.color = 'white' if round.blue == round.white
  end
end

# == Schema Information
#
# Table name: bets
#
#  id         :bigint(8)        not null, primary key
#  value      :integer
#  points     :integer
#  color      :string
#  game_id    :bigint(8)        not null
#  user_id    :bigint(8)        not null
#  round_id   :bigint(8)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  winner     :boolean          default(FALSE)
#
# Indexes
#
#  index_bets_on_game_id   (game_id)
#  index_bets_on_round_id  (round_id)
#  index_bets_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (round_id => rounds.id)
#  fk_rails_...  (user_id => users.id)
#
