# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainServices::Chat::DeleteChatService do
  let(:chat) { FactoryBot.build(:chat) }
  let(:user) { FactoryBot.create(:user4) }

  describe '#call' do
    context 'when user is not the owner of the chat' do
      it 'raises an error' do
        expect { chat.save! }.to change(Chat, :count).from(0).to(1)
        expect { described_class.call(user, chat) }.to(raise_error(DomainErrors::Chat::ChatOwnerError)
                                                         .and(change(Chat, :count).by(0)))
      end
    end

    context 'when user is the owner of the chat' do
      it 'deletes the chat' do
        chat.save!
        expect { described_class.call(chat.owner, chat) }.to change(Chat, :count).from(1).to(0)
      end
    end
  end
end
