Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  delete 'logout', to: 'sessions#destroy'
  resources :users
end
