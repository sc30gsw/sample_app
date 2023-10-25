Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  # 5.4.1演習No.1
  get '/signup',  to: 'users#new'
  # 3.4.4演習No.2_コメントアウト解除
  root 'static_pages#home'
  # 5.3.2演習No.1
  # get  '/help',    to: 'static_pages#help', as: 'helf'
  # 5.3.2演習No.3
  # get  '/help',    to: 'static_pages#help'
  # 5.3.3演習No.1
  # get  '/help',    to: 'static_pages#help', as: 'helf'
  # 5.3.3演習No.2
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get 'up' => 'rails/health#show', as: :rails_health_check
  # 7.3.4演習No.2
  post '/signup',  to: 'users#create'
  get '/login',    to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
end
