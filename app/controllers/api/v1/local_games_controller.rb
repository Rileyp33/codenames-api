class Api::V1::LocalGamesController < ApiController
  protect_from_forgery unless: -> { request.format.json? }

  def show
    render json: Game.find(params["id"]), serializer: LocalGameShowSerializer
  end

  def create
    new_game = Game.create!

    shuffled_words = Word.all.shuffle
    game_words = shuffled_words[0..24]

    card_counts = [8,9]
    shuffled_card_counts = card_counts.shuffle

    colors = ["assassin", "civilian", "civilian", "civilian", "civilian", "civilian", "civilian", "civilian"]

    shuffled_card_counts[0].times do
      colors << "red-agent"
    end

    shuffled_card_counts[1].times do
      colors << "blue-agent"
    end

    shuffled_colors = colors.shuffle

    25.times do |i|
      Cell.create!({ game_id: new_game.id, word_id: game_words[i].id, color: shuffled_colors[i], position: i, flipped_status: "down" })
    end

    render json: { game_id: new_game.id }
  end

end
