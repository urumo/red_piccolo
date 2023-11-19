# frozen_string_literal: true

FactoryBot.define do
  factory :message_history do
    chat_message { nil }
    content { 'MyText' }
  end
end
