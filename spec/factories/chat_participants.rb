# frozen_string_literal: true

FactoryBot.define do
  factory :chat_participant do
    chat { nil }
    user { nil }
    user_role { '' }
    is_kicked { false }
    is_blocked { false }
    is_restricted { false }
  end
end
