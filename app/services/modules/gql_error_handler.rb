# frozen_string_literal: true

module Modules
  module GqlErrorHandler
    def with_error_handling
      yield
    rescue StandardError => e
      Rails.logger.error("GraphQL Error: #{e.message}")
      GraphQL::ExecutionError.new(e.message)
    end
  end
end
