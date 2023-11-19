# frozen_string_literal: true

module DomainServices
  module Chat
    class DeleteChatService < ApplicationService
      attr_reader :user, :chat

      def initialize(user, chat)
        super()
        @user = user
        @chat = chat
      end

      def call
        raise DomainErrors::Chat::ChatOwnerError if chat.owner != user

        ActiveRecord::Base.transaction { chat.destroy! }

        chat
      end
    end
  end
end
