class Game < ApplicationRecord
  has_many :game_users
  has_many :users, through: :game_users
  has_many :rounds

  def standings
    users.map do |user|
      { email: user.email, points: user.points(self) }
    end.sort_by { |user| -user[:points] }
  end
end

# == Schema Information
#
# Table name: games
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
