# frozen_string_literal: true

module DomainServices
  module Chat
    class DeleteChatService < ApplicationService
      attr_reader :user, :chat

      def initialize(user, chat_id)
        super()
        @user = user
        @chat = ::Chat.find(chat_id)
      end

      def call
        raise DomainErrors::Chat::ChatOwnerError if chat.owner != user

        ActiveRecord::Base.transaction { chat.destroy! }

        chat
      end
    end
  end
end
