# frozen_string_literal: true

module DomainServices
  module Chat
    class CreateChatService < ApplicationService
      attr_reader :current_user, :chat_name, :description

      def initialize(current_user, chat_name, description)
        super()
        raise DomainErrors::Chat::NoOwnerError unless current_user
        raise DomainErrors::Chat::NoTitleError unless chat_name
        @current_user = current_user
        @chat_name = chat_name
        @description = description
      end

      def call
        ::Chat.create!(title: chat_name, description:, users: [current_user])
      end
    end
  end
end
