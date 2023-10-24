Rails.application.routes.draw do
  scope '(:locale)', locale: /en|es/ do
    resources :users, except: ['create']
    root 'links#index'
    get 'auth/:provider/callback', to: 'sessions#create'
    get 'sessions/sign_out', to: 'sessions#destroy'
    # resources :sessions, only: %w[new create]
    resources :links

    get 'terms', to: 'application#terms'
    get 'privacy', to: 'application#privacy'
  end
end
