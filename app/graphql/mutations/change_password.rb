# frozen_string_literal: true

module Mutations
  class ChangePassword < BaseMutation
    field :success, GraphQL::Types::Boolean, null: false

    argument :old_password, String, required: true
    argument :new_password, String, required: true
    argument :new_password_confirmation, String, required: true

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
