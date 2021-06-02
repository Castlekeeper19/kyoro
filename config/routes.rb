Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboard#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :edit, :update]
  resources :surveys, only: [:index, :show, :new, :create ]
  resources :user_answers, only: [:index, :show, :update ]

  get '/dashboard', to: 'dashboard#index'
end
