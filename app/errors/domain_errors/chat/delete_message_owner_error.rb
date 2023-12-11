# frozen_string_literal: true

module DomainErrors
  module Chat
    class DeleteMessageOwnerError < ApplicationError
      def message = I18n.t('errors.delete_message_owner')
    end
  end
end
