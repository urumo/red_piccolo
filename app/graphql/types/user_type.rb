# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String
    field :user_setting, UserSettingType, null: false
    field :blocked_users, [UserType], null: false
    field :chats, [ChatType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :role, UserRoleType, null: false
  end
end
