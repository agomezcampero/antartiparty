class GameUser < ApplicationRecord
  include PowerTypes::Observable

  belongs_to :game
  belongs_to :user
  has_many :bets
end

# == Schema Information
#
# Table name: game_users
#
#  id         :bigint(8)        not null, primary key
#  game_id    :bigint(8)        not null
#  user_id    :bigint(8)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_game_users_on_game_id  (game_id)
#  index_game_users_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (user_id => users.id)
#
