# frozen_string_literal: true

require 'sneakers'
require 'sneakers/metrics/logging_metrics'

AMPQ_URL = ENV.fetch('RABBITMQ_URL') do |key|
  raise "Missing environment variable #{key}" if Rails.env.production?

  'amqp://guest:guest@localhost:5672'
end

Sneakers.configure(metrics: Sneakers::Metrics::LoggingMetrics.new)
Sneakers.logger.level = Rails.env.production? ? Logger::WARN : Logger::DEBUG
Sneakers.logger = Rails.logger
Sneakers.configure heartbeat: 30,
                   amqp: AMPQ_URL,
                   vhost: ENV.fetch('RABBITMQ_VHOST', '/'),
                   workers: 4,
                   threads: 4,
                   pid_path: 'tmp/pids/sneakers.pid',
                   env: Rails.env,
                   hooks: {
                     before_fork: -> { ActiveRecord::Base.connection_pool.disconnect! },
                     after_fork: -> { ActiveRecord::Base.establish_connection }
                   }
Sneakers.logger.info "Sneakers configured for #{Rails.env} environment"
