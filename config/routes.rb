Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    # TODO
    get 'home', to: 'users#home'

    post 'signup', to: 'users#create'
    post 'login',  to: 'sessions#create'
    post 'logout', to: 'sessions#destroy'

    resources :users do
      post 'follow'
      post 'unfollow'

      resources :posts
    end
  end
end
