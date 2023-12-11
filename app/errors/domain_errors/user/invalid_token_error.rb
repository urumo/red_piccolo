# frozen_string_literal: true

module DomainErrors
  module User
    class InvalidTokenError < ApplicationError
      def message = I18n.t('errors.invalid_token')
    end
  end
end
