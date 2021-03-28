class BetObserver < PowerTypes::Observer
  after_create :broadcast_changes

  def broadcast_changes
    ActionCable.server.broadcast(
      "game_#{game.id}",
      bets: { missing: bets_missing }
    )

    if bets_missing.zero?
      round.calculate_winners
      broadcast_results
    end
  end

  def broadcast_results
    ActionCable.server.broadcast(
      "game_#{game.id}",
      results: {
        white: ActiveModel::Serializer::CollectionSerializer.new(
          bets_by_color('white'), each_serializer: BetSerializer
        ),
        blue: ActiveModel::Serializer::CollectionSerializer.new(
          bets_by_color('blue'), each_serializer: BetSerializer
        )
      },
      standings: game.standings
    )
  end

  def bets_by_color(color)
    Bet.where(game: game, round: round, color: color).order(value: :desc)
  end

  def bets_missing
    game.users.count - round.bets.count
  end

  def game
    @game ||= object.game
  end

  def round
    @round ||= object.round
  end
end
