# frozen_string_literal: true

module DomainServices
  module Chat
    class EditMessageService < ApplicationService
      attr_reader :user, :message, :new_content

      def initialize(user, message, new_content)
        super()
        @user = user
        @message = message
        @new_content = new_content
      end

      def call
        raise DomainErrors::Chat::EditMessageOwnerError unless message.user == user

        ActiveRecord::Base.transaction do
          message.content = new_content || message.content
          message.save!
        end
        message
      end
    end
  end
end
