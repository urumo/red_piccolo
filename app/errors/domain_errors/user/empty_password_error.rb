# frozen_string_literal: true

module DomainErrors
  module User
    class EmptyPasswordError < ApplicationError
      def message = I18n.t('errors.empty_password')
    end
  end
end
