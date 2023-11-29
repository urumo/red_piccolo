# frozen_string_literal: true

module Types
  # rubocop:disable GraphQL/ObjectDescription
  module NodeType
    include Types::BaseInterface
    # Add the `id` field
    include GraphQL::Types::Relay::NodeBehaviors
  end
  # rubocop:enable GraphQL/ObjectDescription
end
