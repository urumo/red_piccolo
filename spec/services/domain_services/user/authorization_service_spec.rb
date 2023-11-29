# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::User::AuthorizationService do
  let(:not_valid_jwt) { 'not a jwt' }

  describe '#call' do
    context 'when token is valid' do
      it 'returns the user' do
        user = FactoryBot.create(:user)
        token = ApplicationServices::JwtService.encode({ user_id: user.id })
        expect(described_class.call(token)).to eq(user)
      end
    end

    context 'when token is not a valid jwt' do
      it 'raises an error' do
        expect { described_class.call(not_valid_jwt) }.to raise_error(DomainErrors::User::AuthorizationError)
      end
    end

    context 'when token is expired' do
      it 'raises an error' do
        user = FactoryBot.create(:user)
        token = ApplicationServices::JwtService.encode({ user_id: user.id }, 1.second.from_now.to_i)
        sleep 2
        expect { described_class.call(token) }.to raise_error(DomainErrors::User::AuthorizationError)
      end
    end
  end
end
