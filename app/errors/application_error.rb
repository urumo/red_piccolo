# frozen_string_literal: true

class ApplicationError < StandardError
  def initialize(**args, &block)
    raise ArgumentError, 'Change the error message' if message == 'CHANGE ME'

    super
  end
end
