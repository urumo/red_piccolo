# frozen_string_literal: true

module DomainServices
  module User
    class LoginService < ApplicationService
      attr_reader :email, :password

      def initialize(email, password)
        super()
        @email = email
        @password = password
      end

      def call
        user = ::User.find_by(email:)
        raise 'User not found' unless user

        raise 'Invalid password' unless user.authenticate(password)

        { token: ApplicationServices::JwtService.encode(user_id: user.id) }
      end
    end
  end
end
