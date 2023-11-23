# frozen_string_literal: true

module Types
  class UserRoleType < Types::BaseEnum
    description 'User role enum'

    value 'user'
    value 'moderator'
    value 'admin'
    value 'superadmin'
  end
end
