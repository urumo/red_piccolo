# frozen_string_literal: true

module Mutations
  class Login < BaseMutation
    field :jwt, Types::JwtType, null: false

    argument :user_details, Types::UserInputType, required: true

    def resolve(user_details:)
      with_error_handling do
        with_authorization do
          token = DomainServices::User::LoginService.call(user_details.email, user_details.password)
          { jwt: token }
        end
      end
    end
  end
end
