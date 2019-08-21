Rails.application.routes.draw do

  defaults format: :json do
    namespace :api do
      namespace :v1 do
        resource :session, only: [:create, :show, :destroy] do
          put 'forgot_password', to: 'sessions#forgot_password'
        end
        devise_for :users, controllers: { registrations: "api/v1/registrations", sessions: "api/v1/sessions", omniauth_callbacks: "api/v1/users/omniauth_callbacks" }
        resource :registration, only: [:create, :update, :destroy]
        resource :sessions, only: [:create, :show, :forgot_password]
        post 'users/users_index' => 'users#users_index'
        post 'users/search' => 'users#search'
        post 'request_update' => 'requests#request_update'
        post 'post_index' => 'posts#post_index'
        post 'request_index' => 'requests#request_index'
        post 'comment_delete' => 'comments#comment_delete'
        post 'like_delete' => 'likes#like_delete'
        post 'post_delete' => 'posts#post_delete'
        post 'show_profile' => 'profiles#show_profile'
        resources :posts, only: [:create, :show, :update]
        resources :comments, only: [:create, :update]
        resources :likes, only: [:create]
        resources :profiles, only: [:update]
        resources :requests, only: [:create]
      end
    end
  end

end
