# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::User::BlockUserService do
  let(:current_user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user2) }
  describe '#call' do
    context 'self block' do
      it 'raises self block error' do
        expect { described_class.call(current_user, current_user) }.to raise_error(DomainErrors::User::SelfBlockError)
      end
    end

    context 'other user block' do
      it 'creates a blocked user' do
        expect { described_class.call(current_user, other_user) }.to change(BlockedUser, :count).by(1)
      end
    end
  end
end
