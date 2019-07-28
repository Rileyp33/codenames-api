class LocalGameShowSerializer < ActiveModel::Serializer
  attributes :game_id, :codename, :cells, :red_score, :red_total, :blue_score, :blue_total, :assassin, :result

  def game_id
    object.id
  end

  def codename
    object.codename
  end

  def cells
    cells = []
    object.cells.each do |c|
      cell_data = {}
      cell_data["cell_id"] = c.id
      cell_data["word"] = c.word.word
      cell_data["color"] = c.color
      cell_data["position"] = c.position
      cell_data["flipped_status"] = c.flipped_status
      cells << cell_data
    end
    return cells
  end

  def red_score
    object.cells.where(color: "red-agent", flipped_status: "up").length
  end

  def blue_score
    object.cells.where(color: "blue-agent", flipped_status: "up").length
  end

  def assassin
    object.cells.where(color: "assassin", flipped_status: "up").length
  end

  def red_total
    red_total = object.cells.where(color: "red-agent").length
  end

  def blue_total
    blue_total = object.cells.where(color: "blue-agent").length
  end

  def result
    if red_score === red_total
      "Red team wins!"
    elsif blue_score === blue_total
      "Blue team wins!"
    elsif assassin === 1
      "Assassin contacted. Game over."
    end
  end

end
