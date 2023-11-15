# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::Chat::AddUserToChatService do
  let(:chat) { FactoryBot.build(:chat) }
  let(:user) { FactoryBot.build(:user4) }

  setup do
    chat.save!
    user.save!
  end

  describe '#call' do
    context 'when user is not an admin' do
      it 'raises DomainErrors::Chat::NotAnAdminError' do
        expect do
          described_class.new(chat, user, user).call
        end.to raise_error(DomainErrors::Chat::NotAnAdminError)
      end
    end
    context 'when user is already in chat' do
      it 'raises DomainErrors::Chat::UserAlreadyInChatError' do
        expect do
          described_class.new(chat, chat.owner, chat.owner).call
        end.to raise_error(DomainErrors::Chat::UserAlreadyInChatError)
      end
    end
    context 'when user is not in chat' do
      it 'adds user to chat' do
        expect { described_class.new(chat, chat.owner, user).call }.to change { chat.users.count }.by(1)
      end
      it 'creates chat participant' do
        expect { described_class.new(chat, chat.admins.first, user).call }
          .to change { chat.chat_participants.count }.by(1)
      end
    end
  end
end
