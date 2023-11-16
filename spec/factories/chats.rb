# frozen_string_literal: true

FactoryBot.define do
  factory :chat do
    title { 'MyString' }
    description { 'MyString' }
    chat_participants do
      [
        FactoryBot.build(:chat_participant_owner),
        FactoryBot.build(:chat_participant_admin),
        FactoryBot.build(:chat_participant_member)
      ]
    end
    chat_messages do
      Array.new(30).map { FactoryBot.build(:chat_message, user: chat_participants.first.user) }
    end
  end
end
