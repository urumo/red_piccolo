# frozen_string_literal: true

module DomainErrors
  module User
    class InvalidPasswordError < StandardError
      def message = I18n.t('errors.invalid_password')
    end
  end
end
