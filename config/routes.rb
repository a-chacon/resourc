Rails.application.routes.draw do
  scope '(:locale)', locale: /en|es/ do
    get 'tag_suggestions', to: 'tags#suggestions'
    get 'open_graph', to: 'links#open_graph'
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
