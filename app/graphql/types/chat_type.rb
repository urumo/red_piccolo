# frozen_string_literal: true

module Types
  class ChatType < Types::BaseObject
    description 'Chat type'
    field :admins, [UserType], null: false, description: 'Admins'
    field :chat_messages, [ChatMessageType], null: false, description: 'Chat messages'
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false, description: 'Created at'
    field :description, String, description: 'Description'
    field :id, ID, null: false, description: 'ID'
    field :owner, UserType, null: false, description: 'Owner'
    field :title, String, null: false, description: 'Title'
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false, description: 'Updated at'
    field :users, [UserType], null: false, description: 'Users'
  end
end
