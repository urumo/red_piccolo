# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::Chat::FindMessageService do
  let(:chat) { FactoryBot.create(:chat) }
  let(:user) { FactoryBot.create(:user4) }
  describe '#call' do
    context 'when user is not in chat' do
      it 'messages are empty' do
        expect(described_class.call(user, chat, '')).to be_empty
      end
    end
    context 'when user doesnt have messages' do
      it 'messages are empty' do
        expect(described_class.call(user, nil, '')).to be_empty
      end
    end
    context 'when global search' do
      it 'messages are not empty' do
        expect(described_class.call(chat.owner, nil, '')).not_to be_empty
      end
    end
    context 'when chat search' do
      it 'messages are not empty' do
        expect(described_class.call(chat.owner, chat, '')).not_to be_empty
      end
    end
  end
end
