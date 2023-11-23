# frozen_string_literal: true

Rails.application.routes.draw do
  scope :identity do
    get '/', to: 'user#index'
    get '/auth', to: 'user#auth'
    post '/login', to: 'user#login'
    delete '/logout', to: 'user#logout'
    post '/register', to: 'user#register'
    patch '/block', to: 'user#block'
    patch '/settings', to: 'user#settings'
    get '/id/:id', to: 'user#id'
  end

  root to: 'home#index'
  get '/home/index', to: 'home#index'
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'
  get 'up' => 'rails/health#show', as: :rails_health_check
end
