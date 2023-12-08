# frozen_string_literal: true

require 'graphql/rake_task'
GraphQL::RakeTask.new(
  schema_name: 'RedPiccoloSchema',
  directory: 'app/javascript/types/graphql'
)
