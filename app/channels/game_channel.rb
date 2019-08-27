class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_#{params[:game_id]}"
  end

  def receive(data)
    game_data = {}

    clicked_id = data["cell_id"]
    game = Game.find_by(id: params[:game_id])

    selected_cell = game.cells.find_by(id: clicked_id)
    selected_cell.flipped_status = "up"
    selected_cell.save

    cells = []
    game.cells.each do |c|
      cell_data = {}
      cell_data["cell_id"] = c.id
      cell_data["word"] = c.word.word
      cell_data["color"] = c.color
      cell_data["position"] = c.position
      cell_data["flipped_status"] = c.flipped_status
      cells << cell_data
    end

    red_score = game.cells.where(color: "red-agent", flipped_status: "up").length
    blue_score = game.cells.where(color: "blue-agent", flipped_status: "up").length
    assassin = game.cells.where(color: "assassin", flipped_status: "up").length
    red_total = game.cells.where(color: "red-agent").length
    blue_total = game.cells.where(color: "blue-agent").length

    if red_score === red_total && game.result === nil
      game.result = "Red team wins!"
      game.save
    elsif blue_score === blue_total && game.result === nil
      game.result = "Blue team wins!"
      game.save
    elsif assassin === 1 && game.result === nil
      game.result = "Assassin contacted. Game over."
      game.save
    end

    result = game.result

    game_data["cells"] = cells
    game_data["red_score"] = red_score
    game_data["blue_score"] = blue_score
    game_data["assassin"] = assassin
    game_data["result"] = result

    ActionCable.server.broadcast("game_#{params[:game_id]}", game_data)
  end
end