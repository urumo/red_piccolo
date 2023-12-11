# frozen_string_literal: true

module DomainErrors
  module User
    class EmailAlreadyTakenError < ApplicationError
      def message = I18n.t('errors.email_already_taken')
    end
  end
end
