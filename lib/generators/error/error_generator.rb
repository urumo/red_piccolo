# frozen_string_literal: true

module Generators
  module Error
    class ErrorGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      def create_error_file
        template 'error.template', "app/errors/domain_errors/#{file_path}_error.rb"
      end
      argument :name, type: :string
    end
  end
end
