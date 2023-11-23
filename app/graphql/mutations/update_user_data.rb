# frozen_string_literal: true

module Mutations
  class UpdateUserData < BaseMutation
    field :user, Types::UserType, null: false

    argument :user_details, Types::UserInputType, required: true

    def resolve(user_details:)
      with_error_handling do
        with_authorization do
          user = DomainServices::User::AddUserDatumService.call(
            @current_user, user_details.first_name,
            user_details.last_name, user_details.date_of_birth
          )
          { user: }
        end
      end
    end
  end
end
