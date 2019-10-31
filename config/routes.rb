Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:show]
    end
  end 

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: %i[show create update destroy]
      resources :profiles, only: %i[show create destroy]
      resources :tokens, only: [:create]
    end
  end
end
