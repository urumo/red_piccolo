# frozen_string_literal: true

module Types
  class ChatType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :description, String
    field :users, [UserType], null: false
    field :owner, UserType, null: false
    field :admins, [UserType], null: false
    field :chat_messages, [ChatMessageType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
