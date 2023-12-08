# frozen_string_literal: true

module Modules
  module GqlErrorHandler
    include WithTransaction

    def with_error_handling(&block)
      Rails.error.record { with_transaction(&block) }
    rescue StandardError => e
      Rails.logger.error("GraphQL Error: #{e.message}")
      GraphQL::ExecutionError.new(e.message)
    end
  end
end
