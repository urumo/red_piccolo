# frozen_string_literal: true

module Types
  class UserSettingType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String
    field :last_name, String
    field :date_of_birth, GraphQL::Types::ISO8601Date
    field :user_id, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
