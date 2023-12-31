# frozen_string_literal: true

module DomainErrors
  module User
    class NewPasswordDoesntMatchError < ApplicationError
      def message = I18n.t('errors.new_password_doesnt_match')
    end
  end
end
