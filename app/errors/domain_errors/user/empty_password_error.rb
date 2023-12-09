# frozen_string_literal: true

module DomainErrors
  module User
    class EmptyPasswordError < StandardError
      def message = I18n.t('errors.empty_password')
    end
  end
end
