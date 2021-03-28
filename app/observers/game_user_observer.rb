class GameUserObserver < PowerTypes::Observer
  after_create :broadcast_changes

  def broadcast_changes
    ActionCable.server.broadcast(
      "game_#{object.game_id}",
      user: object.user
    )
  end
end
