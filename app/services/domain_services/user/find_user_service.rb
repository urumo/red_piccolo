# frozen_string_literal: true

module DomainServices
  module User
    class FindUserService < ApplicationService
      attr_reader :criteria

      def initialize(criteria)
        @criteria = criteria
        super()
      end

      def call
        ::User.joins(:user_setting).where('public.user_settings.full_name ilike ?', "%#{criteria}%")
      end
    end
  end
end
