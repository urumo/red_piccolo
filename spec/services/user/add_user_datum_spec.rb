# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::User::AddUserDatumService do
  let(:user) { FactoryBot.create(:user) }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:date_of_birth) { Faker::Date.birthday(min_age: 18, max_age: 65) }

  describe '#call' do
    context 'changes first name' do
      it 'returns user with changed first name' do
        expect(described_class.call(user, first_name, nil, nil).user_setting.first_name).to eq(first_name)
      end
    end

    context 'changes last name' do
      it 'returns user with changed last name' do
        expect(described_class.call(user, nil, last_name, nil).user_setting.last_name).to eq(last_name)
      end
    end

    context 'changes date of birth' do
      it 'returns user with changed date of birth' do
        expect(described_class.call(user, nil, nil, date_of_birth).user_setting.date_of_birth).to eq(date_of_birth)
      end
    end

    context 'changes first name, last name and date of birth' do
      subject { described_class.call(user, first_name, last_name, date_of_birth) }
      it 'returns user with changed first name, last name and date of birth' do
        subject
        expect(user.user_setting.first_name).to eq(first_name)
        expect(user.user_setting.last_name).to eq(last_name)
        expect(user.user_setting.date_of_birth).to eq(date_of_birth)
      end
    end
  end
end
