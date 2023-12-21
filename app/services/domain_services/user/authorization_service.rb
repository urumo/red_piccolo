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
        payload = ApplicationServices::JwtService.decode(token)
        ::User.with_user_setting.find(payload['user_id'])
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        raise DomainErrors::User::AuthorizationError
      end
    end
  end
end
