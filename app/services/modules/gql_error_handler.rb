# frozen_string_literal: true

module Modules
  module GqlErrorHandler
    def with_error_handling
      yield
    rescue StandardError => e
      GraphQL::ExecutionError.new(e.message)
    end
  end
end
