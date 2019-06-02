class Api::V1::LocalGamesController < ApiController
  def show
    render json: Game.find(params["id"]), serializer: LocalGameShowSerializer
  end
end
