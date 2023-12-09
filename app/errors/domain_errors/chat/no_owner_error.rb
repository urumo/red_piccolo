# frozen_string_literal: true

module DomainErrors
  module Chat
    class NoOwnerError < StandardError
      def message = I18n.t('errors.no_owner')
    end
  end
end
