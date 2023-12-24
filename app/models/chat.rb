# frozen_string_literal: true

class Chat < ApplicationRecord
  has_many :chat_participants, dependent: :destroy
  has_many :users, through: :chat_participants
  has_many :chat_messages, dependent: :destroy
  alias messages chat_messages

  scope :with_users, -> { left_joins(:users) }
  scope :with_messages, -> { left_joins(:chat_messages) }

  validates :users, presence: true

  validates :title, presence: true, length: { minimum: 1 }

  def owner = users.find_by(chat_participants: { user_role: :owner })

  def admins = users.where(chat_participants: { user_role: :admin })

  after_create do
    chat_participants.update!(user: users.first, user_role: :owner) unless owner
  end

  def admin_or_owner?(user) = admins.include?(user) || owner == user

  after_save do
    chat_participants.each do |participant|
      ApplicationCable::Chat::MessagesChannel.broadcast_to(
        "messages_#{participant.user_id}",
        {
          transmission_type: 'chat_updated',
          chat: { id:, title:, description: }
        }.to_json
      )
    end
  end
end
