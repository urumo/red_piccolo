# frozen_string_literal: true

module Types
  class UserPasswordInputType < Types::BaseInputObject
    description 'User password input type'

    argument :new_password, String, required: true, description: 'New password'
    argument :new_password_confirmation, String, required: true, description: 'New password confirmation'
    argument :old_password, String, required: true, description: 'Old password'
  end
end
