class Api::V1::LocalGamesController < ApiController
  skip_before_action :verify_authenticity_token

  def show
    if params["codename"] === Game.find(params["id"]).codename 
      render json: Game.find(params["id"]), serializer: LocalGameShowSerializer
    else
      render json: {
        error: "Invalid codename for Game ID: #{params["id"]}"
      }
    end
  end

  def create
    new_game = Game.create!({ codename: params["local_game"]["codename"] })

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

    render json: { 
      game_id: new_game.id, 
      codename: new_game.codename 
    }
  end
end
