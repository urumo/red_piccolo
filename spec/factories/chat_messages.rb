# frozen_string_literal: true

FactoryBot.define do
  factory :chat_message do
    chat { nil }
    user { nil }
    content { Faker::Lorem.sentence }
  end
end
