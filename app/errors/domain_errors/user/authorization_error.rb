# frozen_string_literal: true

module DomainErrors
  module User
    class AuthorizationError < ApplicationError
      def message = I18n.t('errors.authorization')
    end
  end
end
