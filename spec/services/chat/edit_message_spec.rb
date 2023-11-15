# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::Chat::EditMessageService do
  let(:chat) { FactoryBot.create(:chat) }
  let(:new_content) { 'new content' }

  describe '#call' do
    context 'chat' do
      it 'has 1 message' do
        expect(chat.chat_messages.count).to eq(1)
      end
    end
    context 'when user is not the owner of the message' do
      it 'raises an error' do
        message = chat.chat_messages.first
        user = FactoryBot.create(:user4)
        expect { described_class.call(user, message, 'new content') }
          .to raise_error(DomainErrors::Chat::EditMessageOwnerError)
      end
    end

    context 'when user is the owner of the message' do
      it 'edits the message' do
        message = chat.chat_messages.first
        user = message.user
        expect(described_class.call(user, message, new_content).content)
          .to eq(new_content)
      end

      it 'adds the old message to the history' do
        message = chat.chat_messages.first
        user = message.user
        expect { described_class.call(user, message, 'some new content') }.to change { MessageHistory.count }.by(1)
      end
    end
  end
end
