# frozen_string_literal: true

module DomainErrors
  module Chat
    class UserAlreadyInChatError < StandardError
      def message = I18n.t('errors.user_already_in_chat')
    end
  end
end
