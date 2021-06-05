Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # resources :user_answers, only: [ :index, :show]
      post '/user_answers', to: 'user_answers#webhook', as: :user_answers
    end
  end

  resources :users, only: [:index, :show, :edit, :update]
  resources :surveys, only: [:index, :show, :new, :create ]
  resources :user_answers, only: [:index, :show, :update ]

  get '/dashboard', to: 'dashboard#index'
end
