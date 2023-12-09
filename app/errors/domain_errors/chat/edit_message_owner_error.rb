# frozen_string_literal: true

module DomainErrors
  module Chat
    class EditMessageOwnerError < StandardError
      def message = I18n.t('errors.edit_message_owner')
    end
  end
end
