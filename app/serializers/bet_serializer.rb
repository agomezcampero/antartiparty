class BetSerializer < ActiveModel::Serializer
  attributes :value, :round, :points, :user, :winner
end
