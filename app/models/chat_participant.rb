# frozen_string_literal: true

class ChatParticipant < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  enum user_role: { member: 0, admin: 1 }
end
