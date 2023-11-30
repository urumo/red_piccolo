# frozen_string_literal: true

module Types
  class UserInputType < Types::BaseInputObject
    description 'User input'
    argument :date_of_birth, GraphQL::Types::ISO8601Date, required: false, description: 'Date of birth'
    argument :email, String, required: false, description: 'Email'
    argument :first_name, String, required: false, description: 'First name'
    argument :last_name, String, required: false, description: 'Last name'
    argument :password, String, required: false, description: 'Password'
    argument :password_confirmation, String, required: false, description: 'Password confirmation'
  end
end
