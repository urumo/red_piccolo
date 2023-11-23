# frozen_string_literal: true

module Types
  class UserInputType < Types::BaseInputObject
    argument :email, String, required: false
    argument :password, String, required: false
    argument :password_confirmation, String, required: false
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :date_of_birth, GraphQL::Types::ISO8601Date, required: false
  end
end
