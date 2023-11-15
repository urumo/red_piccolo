# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    email { 'test@email.com' }
    password { 'P@ssw0rd' }
    user_setting do
      FactoryBot.build(:user_setting)
    end
  end

  factory :user2, class: User do
    email { 'fake@email.com' }
    password { 'P@ssw0rd' }
    user_setting do
      FactoryBot.build(:user_setting)
    end
  end
  factory :user3, class: User do
    email { 'fake1@email.com' }
    password { 'P@ssw0rd' }
    user_setting do
      FactoryBot.build(:user_setting)
    end
  end
  factory :user4, class: User do
    email { 'fake2@email.com' }
    password { 'P@ssw0rd' }
    user_setting do
      FactoryBot.build(:user_setting)
    end
  end
end
