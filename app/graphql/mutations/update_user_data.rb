# frozen_string_literal: true

module Mutations
  class UpdateUserData < BaseMutation
    field :user, Types::UserType, null: false

    argument :user_details, Types::UserInputType, required: true

    def resolve(user_details:)
      user = DomainServices::User::AddUserDatumService.call(
        DomainServices::User::AuthorizationService.call(context[:token]), user_details.first_name,
        user_details.last_name, user_details.date_of_birth
      )
      { user: }
    rescue StandardError => e
      GraphQL::ExecutionError.new(e.message)
    end
  end
end
