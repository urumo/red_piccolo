# frozen_string_literal: true

class ChatMessage < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  has_many :message_histories, dependent: :destroy

  validates_presence_of :content
  validates_length_of :content, minimum: 1

  def history = message_histories.order(created_at: :desc).map do |history|
    {
      content: history.content,
      created_at: history.created_at
    }
  end

  def edited? = message_histories.count > 1

  after_save do
    message_histories.create!(content:)
  end
end
