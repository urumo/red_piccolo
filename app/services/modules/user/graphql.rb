# frozen_string_literal: true

module Modules
  module User
    module Graphql
      include Modules::GqlErrorHandler
      include Modules::User::AuthHandler
      def me
        with_error_handling do
          with_authorization do
            sleep 2
            @current_user
          end
        end
      end

      # def self.current_user(context)
      #   DomainServices::User::AuthorizationService.call(context[:token])
      # end
    end
  end
end
