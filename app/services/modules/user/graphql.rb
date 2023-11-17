# frozen_string_literal: true

module Modules
  module User
    module Graphql
      include Modules::GqlErrorHandler
      def self.current_user(ctx)
        @current_user = DomainServices::User::AuthorizationService.call(ctx[:token])
      end

      def me
        with_error_handling { Graphql.current_user(context) }
      end
    end
  end
end
