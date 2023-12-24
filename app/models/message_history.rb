# frozen_string_literal: true

class MessageHistory < ApplicationRecord
  belongs_to :chat_message

  after_create do
    chat_message.chat.users.find_each do |user|
      cm = chat_message.attributes.slice('id', 'content', 'user_id', 'chat_id', 'created_at', 'updated_at')
      usr = user.attributes.slice('id', 'email', 'role', 'tag', 'created_at', 'updated_at')
      ApplicationCable::Chat::MessagesChannel.broadcast_to(
        "messages_#{user.id}",
        { transmission_type: 'message_added',
          message: cm.merge('is_edited' => chat_message.edited?),
          user: usr.merge('full_name' => chat_message.user.full_name) }.to_json
      )
    end
  end
end
