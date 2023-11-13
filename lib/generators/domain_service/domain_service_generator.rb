# frozen_string_literal: true

class DomainServiceGenerator < Rails::Generators::NamedBase
  include Rails::Generators::ResourceHelpers
  source_root File.expand_path('templates', __dir__)

  def create_domain_service_file
    template 'domain_service.template', "app/services/domain_services/#{file_path}_service.rb"
    template 'service_test.template', "spec/services/#{file_path}_spec.rb"
  end

  argument :name, type: :string
  argument :attributes, type: :array, default: [], banner: 'field:type field:type'
end
