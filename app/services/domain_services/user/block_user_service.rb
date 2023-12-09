# frozen_string_literal: true

module DomainServices
  module User
    class BlockUserService < ApplicationService
      attr_reader :current_user, :other_user

      def initialize(current_user, other_user)
        super()

        @current_user = current_user

        @other_user = other_user
      end

      def call
        raise ::DomainErrors::User::SelfBlockError if current_user == other_user

        BlockedUser.create!(user: current_user, other_user:)
      end
    end
  end
end
