# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::User::FindUserService do
  let(:user) { FactoryBot.create(:user) }

  describe '#call' do
    context 'when user exists' do
      let(:criteria) { user.user_setting.full_name }

      it 'returns the user' do
        expect(described_class.call(criteria).first).to eq(user)
      end

      it 'returns the user with the portion of the name' do
        expect(described_class.call(criteria[0..4]).first).to eq(user)
      end
    end

    context 'when user does not exist' do
      let(:criteria) { 'non-existent user' }

      it 'returns an empty array' do
        expect(described_class.call(criteria).count).to be(0)
      end
    end
  end
end
