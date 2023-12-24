require 'base64'

module Presenters
  module Chat
    class ShowPresenter < ApplicationPresenter
      attr_reader :chats, :offset, :per_page

      def initialize(user_id, cursor = nil)
        user = ::User.find(user_id)
        @chats = user.chats
        decoded_cursor = begin
          Base64.decode64(cursor).split(':').map(&:to_i)
        rescue StandardError
          nil
        end
        page = decoded_cursor&.first || 1
        @per_page = decoded_cursor&.last || 10
        @offset = (page - 1) * per_page
        super()
      end

      def result
        {
          chats: chats.map do |chat|
            {
              id: chat.id,
              title: chat.title,
              description: chat.description,
              messages: map_messages(chat),
              users: map_users(chat)
            }
          end
        }
      end

      private

      def map_messages(chat)
        messages = chat.chat_messages.limit(per_page).offset(offset).reverse
        next_cursor = Base64.encode64("#{offset / per_page + 1}:#{per_page}") unless messages.empty?

        {
          messages: messages.map do |message|
            {
              id: message.id,
              content: message.content,
              user: {
                id: message.user.id,
                full_name: message.user.full_name
              },
              is_edited: message.edited?,
              updated_at: message.updated_at
            }
          end,
          next_cursor:
        }
      end

      def map_users(chat)
        chat.chat_participants.map do |participant|
          {
            id: participant.user.id,
            full_name: participant.user.full_name,
            role: participant.user_role,
            tag: participant.user_admin_name
          }
        end
      end
    end
  end
end
