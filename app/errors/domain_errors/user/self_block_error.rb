# frozen_string_literal: true

module DomainErrors
  module User
    class SelfBlockError < StandardError
      def message = I18n.t('errors.self_block')
    end
  end
end
