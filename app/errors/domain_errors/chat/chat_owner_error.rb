# frozen_string_literal: true

module DomainErrors
  module Chat
    class ChatOwnerError < ApplicationError
      def message = I18n.t('errors.chat_owner')
    end
  end
end
