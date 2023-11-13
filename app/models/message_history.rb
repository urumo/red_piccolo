# frozen_string_literal: true

class MessageHistory < ApplicationRecord
  belongs_to :chat_message
end
