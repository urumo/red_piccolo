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

      def call
        user.user_setting.first_name = first_name unless first_name.nil? || first_name.blank?
        user.user_setting.last_name = last_name unless last_name.nil? || last_name.blank?
        user.user_setting.date_of_birth = date_of_birth unless date_of_birth.nil? || date_of_birth.blank?
        user.user_setting.save!
        user
      end
    end
  end
end
