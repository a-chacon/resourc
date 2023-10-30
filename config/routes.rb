Rails.application.routes.draw do
  scope '(:locale)', locale: /en|es/ do
    root 'links#index'
    get 'tag_suggestions', to: 'tags#suggestions'
    get 'open_graph', to: 'links#open_graph'
    resources :users, except: %w[create index]
    get 'auth/:provider/callback', to: 'sessions#create'
    get 'sessions/sign_out', to: 'sessions#destroy'

    resources :tags, only: ['show']
    resources :links, only: %i[index new create]

    get 'terms', to: 'application#terms'
    get 'privacy', to: 'application#privacy'
  end
end
