# frozen_string_literal: true

module Mutations
  class Register < BaseMutation
    field :jwt, Types::JwtType, null: false

    argument :user_details, Types::UserInputType, required: true

    def resolve(user_details:)
      DomainServices::User::RegisterService.call(
        user_details.email, user_details.password, user_details.password_confirmation
      )
      token = DomainServices::User::LoginService.call(user_details.email, user_details.password)
      { jwt: token }
    end
  end
end
