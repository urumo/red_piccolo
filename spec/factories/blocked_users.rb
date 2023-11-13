# frozen_string_literal: true

FactoryBot.define do
  factory :blocked_user do
    user { nil }
    other_user { nil }
    lift_date { '2023-11-13 10:19:54' }
  end
end
