# frozen_string_literal: true

module DomainServices
  module User
    class RegisterService < ApplicationService
      attr_reader :email, :password

      def initialize(email, password)
        super()

        @email = email

        @password = password
      end

      def call
        ::User.new(email:, password:).save!
      end
    end
  end
end
