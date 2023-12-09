# frozen_string_literal: true

module DomainErrors
  module User
    class AuthorizationError < StandardError
      def message = I18n.t('errors.authorization')
    end
  end
end
