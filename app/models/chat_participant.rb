# frozen_string_literal: true

class ChatParticipant < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  enum user_role: { member: 0, admin: 1, owner: 2 }

  validates :user_id, uniqueness: { scope: :chat_id }

  def tag = user_admin_name

  after_save do
    ApplicationCable::Chat::MessagesChannel.broadcast_to(
      "messages_#{user_id}",
      {
        transmission_type: 'chat_participant_updated',
        chat: { id: chat_id,
                participant: user,
                role: user_role,
                tag: }
      }.to_json
    )
  end
end
