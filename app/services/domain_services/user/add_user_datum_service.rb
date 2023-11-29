# frozen_string_literal: true

module DomainServices
  module User
    class AddUserDatumService < ApplicationService
      attr_reader :first_name, :last_name, :date_of_birth, :user

      def initialize(user, first_name, last_name, date_of_birth)
        super()
        @first_name = first_name
        @last_name = last_name
        @date_of_birth = date_of_birth
        @user = user
      end

      # @return <User>
      def call
        user_setting = user.user_setting
        user_setting.first_name = first_name || user.user_setting.first_name
        user_setting.last_name = last_name || user.user_setting.last_name
        user_setting.date_of_birth = date_of_birth || user.user_setting.date_of_birth
        user_setting.full_name = "#{user_setting.first_name} #{user_setting.last_name}"
        user_setting.save!
        user
      end
    end
  end
end
