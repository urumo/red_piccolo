# frozen_string_literal: true

module Mutations
  class ChangePassword < BaseMutation
    description 'Change password'
    field :success, GraphQL::Types::Boolean, null: false, description: 'Success'

    argument :user_password, Types::UserPasswordInputType, required: true, description: 'User password'

    def resolve(user_password:)
      with_error_handling do
        with_authorization do
          success = DomainServices::User::ChangePasswordService.call(
            @current_user,
            user_password[:old_password],
            user_password[:new_password],
            user_password[:new_password_confirmation]
          )
          { success: }
        end
      end
    end
  end
end
