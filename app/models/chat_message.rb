# frozen_string_literal: true

class ChatMessage < ApplicationRecord
  default_scope { with_user }
  scope :with_user, -> { includes(:user) }
  scope :with_chat, -> { includes(:chat) }
  scope :with_message_histories, -> { includes(:message_histories) }
  scope :with_all, lambda {
    with_user
      .with_chat
      .with_message_histories
  }
  belongs_to :chat
  belongs_to :user
  has_many :message_histories, dependent: :destroy

  validates :content, presence: true
  validates :content, length: { minimum: 1 }

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
