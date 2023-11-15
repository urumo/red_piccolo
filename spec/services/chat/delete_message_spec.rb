# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::Chat::DeleteMessageService do
  let(:chat) { FactoryBot.create(:chat) }
  let(:user) { FactoryBot.create(:user4) }
  describe '#call' do
    context 'when user is not the owner of the message' do
      it 'raises an error' do
        message = chat.chat_messages.first
        expect { described_class.call(user, message) }.to raise_error(DomainErrors::Chat::DeleteMessageOwnerError)
      end
    end

    context 'when user is the owner of the message' do
      it 'deletes the message' do
        message = chat.chat_messages.first
        expect { described_class.call(message.user, message) }
          .to(change { ChatMessage.count }.by(-1))
        # .and(
        #   change { MessageHistory.count }.by(-1))
      end

      it 'deletes the message and history of the message' do
        message = chat.chat_messages.first
        message.update!(content: 'updated content')
        expect { described_class.call(message.user, message) }
          .to(change { ChatMessage.count }
                .by(-1)
                .and(
                  change { MessageHistory.count }.by(-2)
                ))
      end
    end
  end
end
