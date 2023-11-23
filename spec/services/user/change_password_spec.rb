# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::User::ChangePasswordService do
  let(:user) { FactoryBot.build(:user) }
  setup do
    user.save!
  end
  describe '#call' do
    context 'when old password is invalid' do
      it 'raises an error' do
        expect do
          described_class.call(user, 'invalid', 'new_password',
                               'new_password')
        end.to raise_error(DomainErrors::User::InvalidPasswordError)
      end
    end

    context 'when new password confirmation does not match' do
      it 'raises an error' do
        expect do
          described_class.call(user, 'P@ssw0rd', 'new_password',
                               'invalid')
        end.to raise_error(DomainErrors::User::NewPasswordDoesntMatchError)
      end
    end

    context 'when new password is empty' do
      it 'raises an error' do
        expect { described_class.call(user, 'P@ssw0rd', '', '') }.to raise_error(DomainErrors::User::EmptyPasswordError)
        expect do
          described_class.call(user, 'P@ssw0rd', nil, nil)
        end.to raise_error(DomainErrors::User::EmptyPasswordError)
      end
    end

    context 'when new password is valid' do
      it 'changes the password' do
        described_class.call(user, 'P@ssw0rd', 'P@ssw0rd2', 'P@ssw0rd2')
        expect(user.authenticate('P@ssw0rd2')).to eq(user)
      end
    end
  end
end
