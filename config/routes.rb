Rails.application.routes.draw do
  scope '(:locale)', locale: /en|es/ do
    resources :feedbacks
    root 'links#index'
    get 'tag_suggestions', to: 'tags#suggestions'
    get 'open_graph', to: 'links#open_graph'
    resources :users, except: %w[create index]
    resources :sessions, only: %w[new create]
    get 'auth/:provider/callback', to: 'sessions#create'
    get 'sessions/sign_out', to: 'sessions#destroy'

    resources :tags, only: ['show']
    resources :links, only: %i[index new create]
    resources :user_links, only: %i[create destroy]

    get 'terms', to: 'pages#terms'
    get 'privacy', to: 'pages#privacy'
    get 'docs', to: 'pages#docs'
  end
end
