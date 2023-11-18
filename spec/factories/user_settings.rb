# frozen_string_literal: true

FactoryBot.define do
  factory :user_setting do
    first_name { 'TestName' }
    last_name { 'TestSurname' }
    date_of_birth { Date.current - 18.years }
  end
end
