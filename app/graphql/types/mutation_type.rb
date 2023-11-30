# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    description 'Mutation root of the system'
    field :change_password, mutation: Mutations::ChangePassword, description: 'Change password'
    field :login, mutation: Mutations::Login, description: 'Login'
    field :register, mutation: Mutations::Register, description: 'Register'
    field :update_user_data, mutation: Mutations::UpdateUserData, description: 'Update user data'
  end
end
