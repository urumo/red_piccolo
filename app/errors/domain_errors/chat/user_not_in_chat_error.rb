# frozen_string_literal: true

module DomainErrors
  module Chat
    class UserNotInChatError < StandardError
      def message = I18n.t('errors.user_not_in_chat')
    end
  end
end
