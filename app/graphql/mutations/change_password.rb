# frozen_string_literal: true

module Mutations
  class ChangePassword < BaseMutation
    field :success, GraphQL::Types::Boolean, null: false

    argument :old_password, String, required: true
    argument :new_password, String, required: true
    argument :new_password_confirmation, String, required: true

    # TODO: define resolve method
    def resolve(old_password:, new_password:, new_password_confirmation:)
      success = DomainServices::User::ChangePasswordService.call(
        DomainServices::User::AuthorizationService.call(context[:token]),
        old_password,
        new_password,
        new_password_confirmation
      )
      { success: }
    end
  end
end
