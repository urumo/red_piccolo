# frozen_string_literal: true

module DomainErrors
  module User
    class NotFoundError < ApplicationError
      def message = I18n.t('errors.user_not_found')
    end
  end
end
