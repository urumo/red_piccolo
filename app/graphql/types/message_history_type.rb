# frozen_string_literal: true

module Types
  class MessageHistoryType < Types::BaseObject
    description 'Message history'
    field :chat_message_id, String, null: false, description: 'Chat message ID'
    field :content, String, description: 'Content'
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false, description: 'Created at'
    field :id, ID, null: false, description: 'ID'
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false, description: 'Updated at'
  end
end
