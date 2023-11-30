# frozen_string_literal: true

FactoryBot.define do
  factory :blocked_user do
    association :user
    association :other_user, factory: :user
    lift_date { Time.zone.now + 1.week }
  end
end
