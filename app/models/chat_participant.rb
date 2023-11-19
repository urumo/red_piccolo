# frozen_string_literal: true

class ChatParticipant < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  enum user_role: { member: 0, admin: 1, owner: 2 }

  validates_uniqueness_of :user_id, scope: :chat_id
end
