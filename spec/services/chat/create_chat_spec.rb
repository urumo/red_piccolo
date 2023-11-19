# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::Chat::CreateChatService do
  let(:owner) { FactoryBot.create(:user) }
  let(:chat_name) { 'Test chat' }
  describe '#call' do
    subject(:create_chat) { described_class.new(owner, chat_name, nil).call }
    context 'throws an error if params are missing' do
      it 'throws an error if owner is missing' do
        expect { described_class.new(nil, chat_name, nil) }.to raise_error(DomainErrors::Chat::NoOwnerError)
      end
      it 'throws an error if chat_name is missing' do
        expect { described_class.new(owner, nil, nil) }.to raise_error(DomainErrors::Chat::NoTitleError)
      end
    end
    context 'creates a chat' do
      it 'creates a chat' do
        expect { described_class.new(owner, chat_name, nil).call }.to change { Chat.count }.by(1)
      end

      it 'creates a chat with the correct title' do
        chat = described_class.new(owner, chat_name, nil).call
        expect(chat.title).to eq(chat_name)
      end

      it 'creates a chat with the correct owner' do
        chat = described_class.new(owner, chat_name, nil).call
        expect(chat.owner.id).to eq(owner.id)
      end
    end

    context 'user' do
      it 'creates a chat with the correct user and the user has only one chat after creating' do
        chat = described_class.new(owner, chat_name, nil).call
        expect(chat.users.count).to eq(1)
        expect(chat.owner).to eq(owner)
        expect(owner.chats.count).to eq(1)
      end
    end
    context 'when creating a chat' do
      it 'changes the Chat count by 1' do
        expect { create_chat }.to change { Chat.count }.by(1)
      end

      it 'sets the correct title for the chat' do
        expect(create_chat.title).to eq(chat_name)
      end

      it 'assigns the correct owner to the chat' do
        expect(create_chat.owner.id).to eq(owner.id)
      end
    end

    context 'when checking user association' do
      it 'associates the chat with the correct user' do
        expect(create_chat.users).to include(owner)
      end

      it 'ensures the user has only one chat after creation' do
        create_chat
        expect(owner.chats.count).to eq(1)
      end
    end
  end
end
