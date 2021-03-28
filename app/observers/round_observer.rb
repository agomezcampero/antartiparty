class RoundObserver < PowerTypes::Observer
  after_create :broadcast_changes

  def broadcast_changes
    ActionCable.server.broadcast(
      "game_#{object.game_id}",
      round: RoundSerializer.new(object)
    )
  end
end
