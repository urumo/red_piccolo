# frozen_string_literal: true

class ApplicationError < StandardError
  DEFAULT_ERROR_MESSAGE = 'CHANGE ME'

  def initialize(msg = nil)
    super
    raise ArgumentError, 'Change the error message' if message == DEFAULT_ERROR_MESSAGE
  end
end
