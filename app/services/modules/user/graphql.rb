# frozen_string_literal: true

module Modules
  module User
    module Graphql
      include Modules::GqlErrorHandler
      include Modules::User::AuthHandler
      def me
        with_error_handling do
          with_authorization do
            @current_user
          end
        end
      end
    end
  end
end
