# frozen_string_literal: true

FactoryBot.define do
  factory :chat_participant_owner, class: 'ChatParticipant' do
    # chat { nil }
    user { FactoryBot.build(:user) }
    user_role { 'owner' }
    is_kicked { false }
    is_blocked { false }
    is_restricted { false }
  end
  factory :chat_participant_admin, class: 'ChatParticipant' do
    # chat { nil }
    user { FactoryBot.build(:user2) }
    user_role { 'admin' }
    is_kicked { false }
    is_blocked { false }
    is_restricted { false }
  end
  factory :chat_participant_member, class: 'ChatParticipant' do
    # chat { nil }
    user { FactoryBot.build(:user3) }
    user_role { 'member' }
    is_kicked { false }
    is_blocked { false }
    is_restricted { false }
  end
end
