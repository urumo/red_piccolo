# frozen_string_literal: true

class ChatMessage < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  has_many :message_histories, dependent: :destroy

  def edited? = message_histories.count > 1

  after_save do
    message_histories.create(content:)
  end
end
