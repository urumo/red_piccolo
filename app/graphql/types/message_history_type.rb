# frozen_string_literal: true

module Types
  class MessageHistoryType < Types::BaseObject
    field :id, ID, null: false
    field :chat_message_id, String, null: false
    field :content, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
