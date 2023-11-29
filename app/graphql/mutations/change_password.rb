# frozen_string_literal: true

module Mutations
  class ChangePassword < BaseMutation
    description 'Change password'
    field :success, GraphQL::Types::Boolean, null: false, description: 'Success'

    argument :new_password, String, required: true, description: 'New password'
    argument :new_password_confirmation, String, required: true, description: 'New password confirmation'
    argument :old_password, String, required: true, description: 'Old password'

    # TODO: define resolve method
    def resolve(old_password:, new_password:, new_password_confirmation:)
      with_error_handling do
        with_authorization do
          success = DomainServices::User::ChangePasswordService.call(
            @current_user,
            old_password,
            new_password,
            new_password_confirmation
          )
          { success: }
        end
      end
    end
  end
end
