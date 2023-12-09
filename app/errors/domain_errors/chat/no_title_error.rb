# frozen_string_literal: true

module DomainErrors
  module Chat
    class NoTitleError < StandardError
      def message = I18n.t('errors.no_title')
    end
  end
end
