# frozen_string_literal: true

module DomainErrors
  module Chat
    class NotAnAdminError < ApplicationError
      def message = I18n.t('errors.not_an_admin')
    end
  end
end
