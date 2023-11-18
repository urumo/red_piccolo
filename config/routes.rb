# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'
  get 'up' => 'rails/health#show', as: :rails_health_check
end
