Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :edit, :update]
  resources :surveys, only: [:index, :show, :new, :create ]
  resources :user_answers, only: [:index, :show, :update ]

  get '/dashboard', to: 'dashboard#index'
end
