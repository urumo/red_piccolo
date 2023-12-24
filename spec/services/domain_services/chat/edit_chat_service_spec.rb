# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::Chat::EditChatService do
  let(:chat) { FactoryBot.create(:chat) }
  let(:user) { FactoryBot.create(:user4) }
  let(:new_chat_title) { 'new chat title' }
  let(:new_chat_description) { 'new chat description' }

  describe '#call' do
    context 'when user is not an admin or the owner' do
      it 'raises an error' do
        expect do
          described_class.call(user, chat.id, 'title', 'description')
        end.to raise_error(DomainErrors::Chat::NotAnAdminError)
      end
    end

    context 'when user is an admin or the owner' do
      it 'updates the chat' do
        chat.chat_participants.create(user:, user_role: :admin)
        expect { described_class.call(user, chat.id, new_chat_title, new_chat_description) && chat.reload }
          .to change(chat, :title).to(new_chat_title)
                                  .and change(chat, :description).to(new_chat_description)
      end
    end
  end
end
