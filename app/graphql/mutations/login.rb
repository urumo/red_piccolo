# frozen_string_literal: true

module Mutations
  class Login < BaseMutation
    field :jwt, Types::JwtType, null: false

    argument :user_details, Types::UserInputType, required: true

    def resolve(user_details:)
      token = DomainServices::User::LoginService.call(user_details.email, user_details.password)
      pp context[:token]
      { jwt: token }
    end
  end
end
