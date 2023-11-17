# frozen_string_literal: true

module DomainServices
  module Chat
    class FindMessageService < ApplicationService
      GLOBAL_SEARCH = 'user_id = ? and content like ?'
      CHAT_SEARCH = "#{GLOBAL_SEARCH} and chat_id = ?}".freeze
      attr_reader :user, :chat, :content

      def initialize(user, chat, content)
        super()
        @user = user
        @chat = chat
        @content = content
      end

      def call = global_search? ? global_search : chat_search

      private

      def global_search? = chat.nil?

      def global_search
        ChatMessage.where('user_id = ? and content like ?', user.id.to_s, "%#{content}%")
      end

      def chat_search
        ChatMessage.where('user_id = ? and chat_id = ? and content like ?', user.id.to_s, chat.id.to_s, "%#{content}%")
      end
    end
  end
end
