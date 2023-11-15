# frozen_string_literal: true

module DomainServices
  module Chat
    class SendMessageService < ApplicationService
      attr_reader :current_user, :chat, :message

      def initialize(current_user, chat, message)
        super()
        @current_user = current_user
        @chat = chat
        @message = message
      end

      def call
        raise DomainErrors::Chat::UserNotInChatError unless chat.users.include?(current_user)

        chat.chat_messages.create!(user: current_user, content: message)
      end
    end
  end
end
