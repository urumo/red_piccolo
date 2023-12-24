# frozen_string_literal: true

module DomainServices
  module Chat
    class AddUserToChatService < ApplicationService
      attr_reader :chat, :current_user, :user

      def initialize(chat, current_user, user)
        super()
        @chat = chat
        @current_user = current_user
        @user = user
      end

      def call
        raise DomainErrors::Chat::NotAnAdminError unless chat.admin_or_owner?(current_user)
        raise DomainErrors::Chat::UserNotInChatError unless current_user_in_chat?
        raise DomainErrors::Chat::UserAlreadyInChatError if user_in_chat?

        chat.chat_participants.create!(user:, user_role: :member)
        chat
      end

      private

      def user_in_chat? = chat.users.include?(user)
      def current_user_in_chat? = chat.users.include?(current_user)
    end
  end
end
