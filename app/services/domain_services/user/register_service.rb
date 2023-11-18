# frozen_string_literal: true

module DomainServices
  module User
    class RegisterService < ApplicationService
      attr_reader :email, :password, :password_confirmation

      def initialize(email, password, password_confirmation)
        super()
        @email = email
        @password = password
        @password_confirmation = password_confirmation
      end

      def call
        raise DomainErrors::User::EmailAlreadyTakenError if ::User.find_by(email:).present?
        raise DomainErrors::User::PasswordConfirmationDidNotMatchError if password != password_confirmation

        ::User.new(email:, password:, password_salt: SecureRandom.hex(16)).save!
      end
    end
  end
end
