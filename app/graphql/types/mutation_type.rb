# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :change_password, mutation: Mutations::ChangePassword
    field :update_user_data, mutation: Mutations::UpdateUserData
    field :register, mutation: Mutations::Register
    field :login, mutation: Mutations::Login
    # TODO: remove me
    field :test_field, String, null: false,
                               description: 'An example field added by the generator'
    def test_field
      'Hello World'
    end
  end
end
