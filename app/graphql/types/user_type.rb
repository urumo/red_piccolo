# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    description 'User'
    field :blocked_users, [UserType], null: false, description: 'Blocked users'
    field :chats, [ChatType], null: false, description: 'Chats'
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false, description: 'Created at'
    field :email, String, null: false, description: 'Email'
    field :id, ID, null: false, description: 'ID'
    field :role, UserRoleType, null: false, description: 'Role'
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false, description: 'Updated at'
    field :user_setting, UserSettingType, null: false, description: 'User setting'
  end
end
