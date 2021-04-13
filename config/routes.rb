Rails.application.routes.draw do

  root 'tasks#index'
  get '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :categories
  resources :tasks

  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
