# frozen_string_literal: true

module DomainServices
  module Chat
    class DeleteMessageService < ApplicationService
      attr_reader :user, :message

      def initialize(user, message)
        super()
        @user = user
        @message = message
      end

      def call
        raise DomainErrors::Chat::DeleteMessageOwnerError unless message.user == user

        message.destroy!
      end
    end
  end
end
