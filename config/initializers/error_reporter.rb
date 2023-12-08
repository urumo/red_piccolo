# frozen_string_literal: true

class ErrorReporter
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    result = app.call(env)
  rescue StandardError => e
    Rails.logger.debug '=' * 50
    Rails.logger.debug e
    Rails.logger.debug '=' * 50
    raise e
  ensure
    result
  end
end

Rails.application.config.middleware.use ErrorReporter
