# frozen_string_literal: true

module Modules
  module User
    module AuthHandler
      def with_authorization
        @current_user = DomainServices::User::AuthorizationService.call(context[:token])
        yield
      end
    end
  end
end
