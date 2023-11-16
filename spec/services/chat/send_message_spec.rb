# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::Chat::SendMessageService do
  let(:chat) { FactoryBot.create(:chat) }
  let(:user) { FactoryBot.create(:user4) }

  describe '#call' do
    context 'chat is correct' do
      it 'has an owner' do
        expect(chat.owner).to be_present
      end

      it 'has an admin' do
        expect(chat.admins.count).to eq(1)
      end

      it 'has 3 users' do
        expect(chat.users.count).to eq(3)
      end

      it 'has 0 messages' do
        expect(chat.chat_messages.count).to eq(30)
      end

      it 'sends a message' do
        described_class.call(chat.owner, chat, 'Hello')
        expect(chat.chat_messages.count).to eq(31)
      end
    end

    context 'user is not in chat' do
      it 'throws an error' do
        expect do
          described_class.call(user, chat, 'Hello')
        end.to raise_error(DomainErrors::Chat::UserNotInChatError)
      end
    end
  end
end
