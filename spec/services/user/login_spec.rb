# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::User::LoginService do
  setup do
    @user = FactoryBot.create(:user)
  end

  describe '#call with correct credentials' do
    it 'returns a token' do
      result = described_class.call(@user.email, 'P@ssw0rd')
      expect(result[:token]).to be_a(String)
    end
  end

  describe '#call with incorrect credentials' do
    it 'raises an error when email is not found' do
      expect do
        described_class.call("#{@user.email}1", 'P@ssw0rd')
      end.to raise_error('User not found')
    end

    it 'raises an error when password is incorrect' do
      expect do
        described_class.call(@user.email, 'P@ssw0rd1')
      end.to raise_error('Invalid password')
    end
  end
end
