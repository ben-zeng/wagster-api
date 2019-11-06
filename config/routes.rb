Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: %i[show create update destroy]

      # resources :match_pairs do
      #   get 'matched_show'
      # end

      resources :profiles, only: %i[show create update destroy profiles_get]
      resources :profiles do
        get 'profiles_get'
        get 'match_show'
        post 'accept'
        post 'reject'
      end

      resources :tokens, only: [:create]

       resources :match_pairs, only: [:show]



    end
  end
end
