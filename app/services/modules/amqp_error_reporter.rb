# frozen_string_literal: true

module Modules
  module AmqpErrorReporter
    include Modules::WithTransaction

    def with_amqp_error_reporting(&block)
      Rails.error.record { with_transaction(&block) }
    end
  end
end
