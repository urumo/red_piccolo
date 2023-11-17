# frozen_string_literal: true

module DomainServices
  module User
    class ChangePasswordService < ApplicationService
      attr_reader :user, :old_password, :new_password, :new_password_confirmation

      def initialize(user, old_password, new_password, new_password_confirmation)
        super()
        @user = user
        @old_password = old_password
        @new_password = new_password
        @new_password_confirmation = new_password_confirmation
      end

      def call
        raise DomainErrors::User::InvalidPasswordError unless user.authenticate(old_password)
        raise DomainErrors::User::NewPasswordDoesntMatchError unless new_password == new_password_confirmation
        raise DomainErrors::User::EmptyPasswordError if new_password.blank?

        user.password = new_password
        user.save!
      end
    end
  end
end
