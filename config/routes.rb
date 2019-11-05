Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: %i[show create update destroy]

      resources :profiles, only: %i[show create update destroy profiles_get]
      resources :profiles do
        get 'profiles_get'
        post 'accept'
        post 'reject'
      end

      resources :tokens, only: [:create]


    end
  end
end
