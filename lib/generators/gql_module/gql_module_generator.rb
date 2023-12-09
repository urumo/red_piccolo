# frozen_string_literal: true

class GqlModuleGenerator < Rails::Generators::NamedBase
  include Rails::Generators::ResourceHelpers
  source_root File.expand_path('templates', __dir__)

  def create_gql_module_file
    template 'gql_module.template', "app/services/modules/#{file_path}.rb"
  end

  argument :name, type: :string
  argument :attributes, type: :array, default: [], banner: 'field:type field:type'
end
