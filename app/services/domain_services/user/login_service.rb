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
        user = ::User.find_by_email(email)
        raise DomainErrors::User::NotFoundError, I18n.t('user.not_found') unless user

        unless user.authenticate(password)
          raise DomainErrors::User::InvalidPasswordError,
                I18n.t('user.invalid_password')
        end

        { token: ApplicationServices::JwtService.encode(user_id: user.id) }
      end
    end
  end
end
