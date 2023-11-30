# frozen_string_literal: true

module Types
  class UserSettingType < Types::BaseObject
    description 'User setting'
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false, description: 'Created at'
    field :date_of_birth, GraphQL::Types::ISO8601Date,  description: 'Date of birth'
    field :first_name, String, description: 'First name'
    field :id, ID, null: false, description: 'ID'
    field :last_name, String, description: 'Last name'
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false, description: 'Updated at'
    field :user_id, String, null: false, description: 'User ID'
  end
end
