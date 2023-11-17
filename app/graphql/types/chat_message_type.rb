# frozen_string_literal: true

module Types
  class ChatMessageType < Types::BaseObject
    field :id, ID, null: false
    field :chat_id, String, null: false
    field :user_id, String, null: false
    field :content, String
    field :message_histories, [MessageHistoryType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
