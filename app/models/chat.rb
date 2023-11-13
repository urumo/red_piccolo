# frozen_string_literal: true

class Chat < ApplicationRecord
  has_many :chat_participants, dependent: :destroy
  has_many :users, through: :chat_participants
  has_many :chat_messages, dependent: :destroy

  def owner = users.find_by(chat_participants: { user_role: :owner })
  def admins = users.where(chat_participants: { user_role: :admin })

  after_create do
    chat_participants.create(user: users.first, user_role: :owner)
  end
end
