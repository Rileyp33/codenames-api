Rails.application.routes.draw do

  namespace 'api' do
    namespace 'v1' do
      resources :local_games, only: [:show, :create]
    end
  end

end
