# frozen_string_literal: true

module Types
  class ChatMessageType < Types::BaseObject
    description 'Chat message type'
    field :chat_id, String, null: false, description: 'Chat ID'
    field :content, String, description: 'Content'
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false, description: 'Created at'
    field :id, ID, null: false, description: 'ID'
    field :message_histories, [MessageHistoryType], null: false, description: 'Message histories'
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false, description: 'Updated at'
    field :user_id, String, null: false, description: 'User ID'
  end
end
