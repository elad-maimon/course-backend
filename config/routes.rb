Rails.application.routes.draw do
  namespace :api, except: [:new, :edit], defaults: { format: :json } do
    # TODO show routes
    # get :home, to: 'users#home'

    post :signup, to: 'users#create'
    post :login,  to: 'sessions#create'
    post :logout, to: 'sessions#destroy'

    resources :users do
      post :follow,   on: :member
      post :unfollow, on: :member

      resources :posts do
        post :like,   on: :member
        post :unlike, on: :member
      end
    end
  end
end
