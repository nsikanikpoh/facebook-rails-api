Rails.application.routes.draw do



  defaults format: :json do
    namespace :api do
      namespace :v1 do
        resources :users, only: [:index, :show]
        resource :session, only: [:create, :show, :destroy] do
          put 'forgot_password', to: 'sessions#forgot_password'
        end
        devise_for :users, controllers: { registrations: "api/v1/registrations", sessions: "api/v1/sessions", omniauth_callbacks: "api/v1/users/omniauth_callbacks" }
        resource :registration, only: [:create, :update, :destroy]
        resource :sessions, only: [:create, :show, :forgot_password]
        get 'users/index'
        get 'privacy' => 'posts#privacy'
        get 'users/search'
        post 'post_index' => 'posts#post_index'
        resources :posts, only: [:create, :show, :edit, :update, :index, :destroy]
        resources :comments, only: [:create, :edit, :update, :destroy]
        resources :likes, only: [:create, :destroy]
        resources :profiles, only: [:show, :edit, :update]
        resources :requests, only: [:create, :update, :index]
      end
    end
  end

end
