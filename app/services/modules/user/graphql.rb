# frozen_string_literal: true

module Modules
  module User
    module Graphql
      include Modules::GqlErrorHandler
      def me
        with_error_handling { Graphql.current_user(context) }
      end
    end
  end
end
