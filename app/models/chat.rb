# frozen_string_literal: true

class Chat < ApplicationRecord
  has_many :chat_participants, dependent: :destroy
  has_many :users, through: :chat_participants
  has_many :chat_messages, dependent: :destroy
end
