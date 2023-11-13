# frozen_string_literal: true

module DomainServices
  module User
    class AuthorizationService < ApplicationService
      attr_reader :token

      def initialize(token)
        super()

        @token = token
      end

      def call
        id = ApplicationServices::JwtService.decode(token)

        ::User.find(id)
      end
    end
  end
end
