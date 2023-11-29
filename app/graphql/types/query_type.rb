# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    description 'Query root of the system'
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    include Modules::User::Graphql

    field :me, Types::UserType, null: false, description: 'Returns logged in user'
  end
end
