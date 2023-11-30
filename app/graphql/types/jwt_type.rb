# frozen_string_literal: true

module Types
  class JwtType < Types::BaseObject
    description 'JWT type'
    field :token, String, description: 'Token'
  end
end
