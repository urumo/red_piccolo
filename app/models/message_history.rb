# frozen_string_literal: true

class MessageHistory < ApplicationRecord
  belongs_to :chat_message

  after_create do
    chat_message.chat.users.each do |user|
      ApplicationCable::Chat::MessagesChannel.broadcast_to(
        "messages_#{user.id}",
        {message: chat_message}.to_json
      )
    end
  end
end
