# frozen_string_literal: true

module Modules
  module WithTransaction
    def with_transaction(&block)
      ActiveRecord::Base.transaction(&block)
    end
  end
end
