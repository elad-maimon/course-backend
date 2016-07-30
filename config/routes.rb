Rails.application.routes.draw do
  apipie

  namespace :api, except: [:new, :edit], defaults: { format: :json } do
    post :login,  to: 'sessions#create'
    post :logout, to: 'sessions#destroy'

    resources :users, only: [:index, :show, :create], controller: 'v1/users' do
      post :follow,   on: :member
      post :unfollow, on: :member

      resources :posts, controller: 'v1/posts' do
        post :like,   on: :member
        post :unlike, on: :member
      end
    end

    namespace :v2 do
      resources :users, only: [:index, :show, :create, :update] do
        resources :posts do
          post :like,   on: :member
          post :unlike, on: :member
        end
      end
    end
  end
end
