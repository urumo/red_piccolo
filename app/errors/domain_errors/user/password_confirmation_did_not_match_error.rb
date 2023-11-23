# frozen_string_literal: true

module DomainErrors
  module User
    class PasswordConfirmationDidNotMatchError < StandardError; end
  end
end
