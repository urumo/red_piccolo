# frozen_string_literal: true

module Generators
  module DomainService
    class DomainServiceGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers
      source_root File.expand_path('templates', __dir__)

      def create_domain_service_file
        create_directories
        template 'domain_service.template', "app/services/domain_services/#{file_path}_service.rb"
        template 'service_test.template', "spec/services/#{file_path}_spec.rb"
      end

      argument :name, type: :string
      argument :attributes, type: :array, default: [], banner: 'field:type field:type'

      def create_directories
        FileUtils.mkdir_p('app/services/domain_services') unless File.directory?('app/services/domain_services')

        FileUtils.mkdir_p('spec/services') unless File.directory?('spec/services')
      end
    end
  end
end
