# frozen_string_literal: true

class ApplicationError < StandardError
  def initialize(msg = nil)
    raise ArgumentError, 'Change the error message' if message == 'CHANGE ME'

    super
  end
end
