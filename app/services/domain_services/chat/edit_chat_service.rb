# frozen_string_literal: true

module DomainServices
  module Chat
    class EditChatService < ApplicationService
      attr_reader :user, :chat, :title, :description

      def initialize(user, chat, title, description)
        super()
        @user = user
        @chat = chat
        @title = title
        @description = description
      end

      def call
        raise DomainErrors::Chat::NotAnAdminError unless chat.owner == user || chat.admins.include?(user)

        chat.update!(title:, description:)
        chat
      end
    end
  end
end
