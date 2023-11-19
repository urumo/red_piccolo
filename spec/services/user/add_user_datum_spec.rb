# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::User::AddUserDatumService do
  let(:user) { FactoryBot.create(:user) }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:date_of_birth) { Faker::Date.birthday(min_age: 18, max_age: 65) }

  subject { described_class.call(user, first_name, last_name, date_of_birth) }
  describe '#call' do
    context 'changes only first name' do
      let(:last_name) { nil }
      let(:date_of_birth) { nil }
      it 'returns user with changed first name' do
        expect(subject.user_setting.first_name).to eq(first_name)
        expect(subject.user_setting.last_name).to be(nil)
      end
    end

    context 'changes only last name' do
      let(:first_name) { nil }
      let(:date_of_birth) { nil }
      it 'returns user with changed last name' do
        expect(subject.user_setting.last_name).to eq(last_name)
        expect(subject.user_setting.first_name).to be(nil)
      end
    end

    context 'changes only date of birth' do
      let(:first_name) { nil }
      let(:last_name) { nil }
      it 'returns user with changed date of birth' do
        expect(subject.user_setting.date_of_birth).to eq(date_of_birth)
        expect(subject.user_setting.first_name).to be(nil)
      end
    end

    context 'changes first name, last name and date of birth' do
      it 'returns user with changed first name, last name and date of birth' do
        subject
        expect(user.user_setting.first_name).to eq(first_name)
        expect(user.user_setting.last_name).to eq(last_name)
        expect(user.user_setting.date_of_birth).to eq(date_of_birth)
      end
    end

    context 'changes nothing if nothing is passed' do
      let(:first_name) { nil }
      let(:last_name) { nil }
      let(:date_of_birth) { nil }
      it 'returns user with unchanged first name, last name and date of birth' do
        expect(subject.user_setting.first_name).to be(nil)
        expect(subject.user_setting.last_name).to be(nil)
        expect(subject.user_setting.date_of_birth).to be(nil)
      end
      it 'returns user with unchanged first name, last name and date of birth' do
        described_class.call(user,
                             Faker::Name.first_name,
                             Faker::Name.last_name,
                             Faker::Date.birthday(min_age: 18, max_age: 65))
        expect(subject.user_setting.first_name).not_to eq(nil)
        expect(subject.user_setting.last_name).not_to eq(nil)
        expect(subject.user_setting.date_of_birth).not_to eq(nil)
      end
    end
  end
end
