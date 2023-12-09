# frozen_string_literal: true

module DomainErrors
  module User
    class EmailAlreadyTakenError < StandardError
      def message = I18n.t('errors.email_already_taken')
    end
  end
end
