# frozen_string_literal: true

module DomainErrors
  module User
    class InvalidPasswordError < ApplicationError
      def message = I18n.t('errors.invalid_password')
    end
  end
end
