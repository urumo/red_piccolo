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
        user = find_user

        validate_password_for(user)

        ApplicationServices::JwtService.encode(user_id: user.id)
      end

      private

      def find_user
        ::User.find_by(email:) || raise(DomainErrors::User::NotFoundError)
      end

      def validate_password_for(user)
        user.authenticate(password) || raise(DomainErrors::User::InvalidPasswordError)
      end
    end
  end
end
