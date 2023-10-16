Rails.application.routes.draw do
  resources :users, except: ['create']
  root 'links#index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'sessions/sign_out', to: 'sessions#destroy'
  # resources :sessions, only: %w[new create]
  resources :links
end
