# frozen_string_literal: true

module DomainErrors
  module User
    class PasswordConfirmationDidNotMatchError < ApplicationError
      def message = I18n.t('errors.password_confirmation_did_not_match')
    end
  end
end
