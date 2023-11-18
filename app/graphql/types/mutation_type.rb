# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :change_password, mutation: Mutations::ChangePassword
    field :update_user_data, mutation: Mutations::UpdateUserData
    field :register, mutation: Mutations::Register
    field :login, mutation: Mutations::Login
  end
end
